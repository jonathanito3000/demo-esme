Rails.application.routes.draw do
  resources :posts
#omniauth_callbacks sirve para manejar las respuestas que se reciban de omniauth
  devise_for :usuarios, controllers: {omniauth_callbacks: "omniauth_callbacks", 
  										registrations: "registrations"}
	get "welcome/index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#index'
end
