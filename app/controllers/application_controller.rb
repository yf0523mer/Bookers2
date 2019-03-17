class ApplicationController < ActionController::Base
	before_action :configure_permitted_parameters, if: :devise_controller?

	def after_sign_in_path_for(resource)
	  flash[:notice] = "Signed in successfully."
	  user_path(current_user)
	end

	def after_sign_out_path_for(resource)
	  flash[:notice] = "Signed out successfully."
	  top_user_path
	end

	# def after_sign_out_path_for(resource)
	# end

  	protected
  		def configure_permitted_parameters
    		devise_parameter_sanitizer.permit(:sign_up, keys: [:name,:email])
   			devise_parameter_sanitizer.permit(:sign_in, keys: [:name])
   			devise_parameter_sanitizer.permit(:account_update, keys: [:name,:email])
  		end
end
