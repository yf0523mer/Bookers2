class BooksController < ApplicationController

    def new
        @book = Book.new
    end

    def create
        @book = Book.new(book_params)
        @book.user_id = current_user.id
        if @book.save
            flash[:notice] = "Book was successfully updated."
            redirect_to book_path(@book.id)
        else
            @books = Book.all
            @user = current_user
            flash[:error] = "Any error has occurred."
            render :index
        end
    end

    def index
    	@book = Book.new
    	@books = Book.all
        @user = current_user
        @users = User.all
    end

    def show
        @book = Book.find(params[:id])
        @book_new = Book.new
        @user = @book.user
    end

    def edit
    	@book = Book.find(params[:id])
         if @book.user != current_user
          flash[:notice] = "Permission error"
          redirect_to user_path(current_user)
         end
    end

    def update
    	@book = Book.find(params[:id])
	    if @book.update(book_params)
	      flash[:notice] = "Book was successfully updated."
	      redirect_to book_path(@book.id)
	    else
          flash[:error] = "Any error has occurred."
	      render action: :edit
    	end
    end

    def destroy
    	book = Book.find(params[:id])
	    book.destroy
        flash[:notice] = "Book was successfully destroyed."
	    redirect_to books_path
    end

 private
    def book_params
        params.require(:book).permit(:title, :opinion)
    end
    def user_params
        params.require(:user).permit(:name, :introduction, :image)
    end

end
