class ApplicationController < ActionController::Base
	
  protect_from_forgery with: :exception

  protected
  def configure_permitted_parameters

  	if(self.class <= Devise::RegistrationsController)

  		self.class.send(:define_method, :resource_params)do
  			 params_require (resource_name).permit(:email, :password, :password_confirmation, :username)
  		end
  	end
  	
  end
end
