class UsersController < ApplicationController
    before_action :authenticate_user!, except: [:top]
	def new
    end

    def create
        user = User.new(user_params)
        if user.save
            redirect_to user_path(current_user)
        else
            redirect_to user_edit_path(current_user)
        end
    end

    def index
    	@users = User.all
        @user = current_user
        @book = Book.new
    end

    def show
    	@user = User.find(params[:id])
        @book = Book.new
    end

    def top
    end

    def edit
        @user = User.find(params[:id])
        if @user.id != current_user.id
           flash[:notice] = "Permission error."
           redirect_to user_path(current_user)
      end
    end

    def update
        @user = User.find(params[:id])

        if  @user.update(user_params)
            flash[:notice] = "User was successfully updated."
            redirect_to user_path(current_user)
        else
            flash[:error] = "Any error has occurred."
            render action: :edit
        end
    end

 private
    def user_params
        params.require(:user).permit(:name, :introduction, :image)
    end

end
