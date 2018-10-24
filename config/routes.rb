Rails.application.routes.draw do
  get 'pages/home'
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'pages#home'
  # get '/pages/:page' => 'pages#show'

  # resources :services, only: [:show]
  # # resources :resources, only: [:show]
  # get 'pages/:id', to: 'resources#show'
  # resources :about, only: [:show]

  PagesController.action_methods.each do |action|
    get "/#{action}", to: "pages##{action}", as: "#{action}_page"
  end
end
