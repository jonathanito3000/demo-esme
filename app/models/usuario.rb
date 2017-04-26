class Usuario < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  devise :omniauthable, omniauth_providers: [:facebook, :twitter]
  #relacion con la tabla usuario
  has_many :posts
  has_many :friendships
  #se utiliza throught para hacer la referencia a la tabla que tendra la realcion y source para el campo que debe buscar
  has_many :follows, through: :friendships, source: :usuario
  has_many :followers_friendships, class_name: "Friendship", foreign_key: "usuario_id" 
  has_many :followers, through: :followers_friendships, source: :friend

  #metodo para seguir amigos
  def follow!(amigo_id)
    self.friendships.create!(friend_id: amigo_id)
    
  end
  #validar que no se pueda seguir a la misma persona
  def can_follow?(amigo_id)
      not amigo_id == self.id or friendships.where(friend_id: amigo_id).size > 0

    
  end
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
