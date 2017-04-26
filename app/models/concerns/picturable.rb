module Picturable
	extend ActiveSupport::Concern 
	#para que funciones ese bloque se pone el inlcude do
	included do
		after_save :guardar_imagen
	end
  #variable para guardar los archivs en una ruta
  #if para que guarde segun de donde se lo sube
  	if respond_to?(:nombre)
  		PATH_ARCHIVOS = File.join Rails.root, "public", "archivos", "attachments"
	else
		PATH_ARCHIVOS = File.join Rails.root, "public", "archivos", "posts"
	end
  #para guardar archivos
  def archivo=(archivo)

  	unless archivo.blank?
  		@archivo = archivo
  		#para que funcione el metodo nombre
  		if self.respond_to? (:nombre)
  				self.nombre = archivo.original_filename
  		end
  		self.extension = archivo.original_filename.split(".").last.downcase
  		
  	end
  	
  end

  def path_imagen

  	File.join PATH_ARCHIVOS, "#{self.id}.#{self.extension}"
  	
  end

  def tiene_archivo
  	File.exists? path_archivo
  end

  private
  def guardar_imagen

	  	if @archivo

	  		FileUtils.mkdir_p PATH_ARCHIVOS
	  		File.open(path_imagen, "wb") do |f|
	  			f.write(@archivo.read)
	  			
	  		end
	  		@archivo = nil
	  end
  	
  end
end