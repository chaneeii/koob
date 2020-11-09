Rails.application.routes.draw do

  root 'pages#home'

  devise_for :users,
             :path =>'',
             :path_names => {:sign_in => 'login', :sign_out => 'logout', :edit =>'profile'},
             :controllers => { :omniauth_callbacks => "users/omniauth_callbacks",
                               :registrations => "registrations"}

  resources :users, only: [:show]
  resources :books
  resources :photos

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
