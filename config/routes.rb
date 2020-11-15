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

  resources :books do
    resources :requests, only: [:create]
  end

  # url 입력할때, 이것은 requests controller의 preload를 실행할 것임.
  get '/preload' => 'requests#preload'
  get '/preview' => 'requests#preview'

  get '/my_requests' => 'requests#my_requests'
  get '/rec_requests' => 'requests#rec_requests'


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
