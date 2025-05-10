Rails.application.routes.draw do
  
  root to: "sessions#new" # Always show login page first

  # User authentication
  get '/signup', to: 'users#new', as: 'new_user'
  post '/users', to: 'users#create'
  delete '/users', to: 'users#destroy', as: 'destroy_user'

  # Sessions
  get '/login', to: 'sessions#new', as: 'login'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy', as: 'logout'

  resources :todos do
    member do
      patch :complete  # This will create complete_todo_path
    end
    collection do
      get 'completed'  # This will create completed_todos_path
    end
  end
  
  resources :categories
  resources :todos
end