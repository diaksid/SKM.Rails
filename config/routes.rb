Rails.application.routes.draw do
  # You can have the root of your site routed with "root"
  root 'statics#home'

  # Contact
  get '/contact', to: 'contact#show'
  post '/contact', to: 'contact#deliver'

  # Activity
  resources :activities, only: [:show]

  # Customer
  resources :customers, only: [:index, :show]

  # Target
  resources :targets, only: [:index, :show]

  # Permit
  resources :permits, only: [:index, :show]

  # Article
  resources :articles, only: [:index, :show]

  # Feedback
  resources :feedbacks, only: [:index, :show]

  # Devise + Active Admin
  devise_for :users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
