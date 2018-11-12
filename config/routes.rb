Rails.application.routes.draw do
  root to: 'conversations#new'
  devise_for :users
  # get 'pages/home'
  get 'conversations/new'
  get 'conversations/:id', to: 'conversations#show', as: 'conversation'
  post 'conversations/add_message', to: 'conversations#add_message', as: 'add_conversation_message'
  post 'conversations/generate_sms', to: 'conversations#generate_sms', as: 'generate_conversation_sms'
  post 'conversations/chat_items', to: 'conversations#chat_items', as: 'add_conversation_transcript'
  post 'conversations/receive'
  # resources :messages, only: [:create, :new]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html


  PagesController.action_methods.each do |action|
    get "/#{action}", to: "pages##{action}", as: "#{action}_page"
  end
end
