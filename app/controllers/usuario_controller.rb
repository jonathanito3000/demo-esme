class UsuarioController < ApplicationController
	def show
			#se busca en la tabla usuario los datos del usuario en cuestion y se almacena en euna variable de clases
			#para poder usar en las vista
			@usuario = Usuario.find(params[:id])
			
	end
end