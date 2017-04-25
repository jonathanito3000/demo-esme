class Usuario < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  devise :omniauthable, omniauth_providers: [:facebook, :twitter]
  #relacion con la tabla usuario
  has_many :posts
  #para decirle al controlador que no tome el email para autenticar
  def email_required?
    false
  end

  #validates es el metodo para realizar las validaciones con los campos de la BD
  validates :username, presence: true, uniqueness: true,
  		length: {in: 8..20, too_short: "Tiene que tener minimo 8 caracteres", too_long: "Maximo 20 caracteres"}
  #sirve para saber si el usuario ya le ha logueado antes con omniauth, recibe como parametro el hash auth
  def self.find_or_create_by_omniath (auth)

  		usuario = Usuario.where(provider: auth[:provider], uid: auth[:uid]).first
  		#si el usuario no se encuentra se lo crea, pero aqui se usan los campos de la tabla user
  		unless usuario
  				usuario = Usuario.create(

  						nombre: auth[:nombre],
  						apellido: auth[:apellido],
  						username: auth[:username],
  						email: auth[:email],
  						uid: auth[:uid],
  						provider: auth[:provider],
  						#devise no permite el campo contraseña en blanco se utiliza friendly_token[0,20] para generar un password aleatorio
  						password: Devise.friendly_token[0,20]

  					)

  		  		
  		  	end  	

          usuario
  end
end
