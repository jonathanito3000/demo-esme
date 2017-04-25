class OmniauthCallbacksController < ApplicationController

	def facebook
		#omniauth.auth es la variable de peticion que contiene toda la informacoion para auntenticar al usuario

		auth = request.env["omniauth.auth"]
		
		data = {

				 nombre: auth.info.first_name,
				 apellido: auth.info.last_name,
				 username: auth.info.nickname,
				 email: auth.info.email,
				 provider: auth.provider,
				 uid:	auth.uid
		}
		
		@usuario = Usuario.find_or_create_by_omniath (data)
		#validar si el usuario ya se creo (persisted devuelve verdadero si el registro ya se creo)
		if @usuario.persisted?
			sign_in_and_redirect @usuario, event: :authentication
		else
			#el metodo errors siver para mostrar los errores, to_sentence traduce a lengua natural
			session[:omniauth_erros] = @usuario.errors.full_messages.to_sentence unless @usuario.save
			session[:omniauth_data] = data
			#si no pudo crear el usuario lo redirige para que cree y corrija erroes
			redirect_to new_usuario_registration_url
		end
	end

	def twitter

		auth = request.env["omniauth.auth"]
		
		data = {

				 nombre: auth.info.name,
				 apellido: "",
				 username: auth.info.nickname,
				 email: "",
				 provider: auth.provider,
				 uid:	auth.uid
		}
		
		@usuario = Usuario.find_or_create_by_omniath (data)
		#validar si el usuario ya se creo (persisted devuelve verdadero si el registro ya se creo)
		if @usuario.persisted?
			sign_in_and_redirect @usuario, event: :authentication
		else
			#el metodo errors siver para mostrar los errores, to_sentence traduce a lengua natural
			session[:omniauth_erros] = @usuario.errors.full_messages.to_sentence unless @usuario.save
			session[:omniauth_data] = data
			#si no pudo crear el usuario lo redirige para que cree y corrija erroes
			redirect_to new_usuario_registration_url
		end
		
	end
end