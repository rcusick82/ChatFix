Rails.application.routes.draw do
  root to: 'conversations#new'
  devise_for :users
  # get 'pages/home'
  get 'conversations/new'
  get 'conversations/:id', to: 'conversations#show', as: 'conversation'
  post 'conversations/:id/messages', to: 'conversations#add_message', as: 'add_conversation_message'
  # resources :messages, only: [:create, :new]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  PagesController.action_methods.each do |action|
    get "/#{action}", to: "pages##{action}", as: "#{action}_page"
  end
end
