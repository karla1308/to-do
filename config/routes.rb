Rails.application.routes.draw do
  
  root to: "landing#welcome"

  # User authentication
  get "/signup", to: "users#new", as: "new_user"
  post "/users", to: "users#create"
  delete "/users", to: "users#destroy", as: "destroy_user"

  # Sessions
  get "/login", to: "sessions#new", as: "login"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy", as: "logout"

  get 'welcome', to: 'landing#welcome', as: :welcome_landing
  get 'getstarted', to: 'landing#getstarted', as: :getstarted_landing

  resources :todos do
    member do
      patch :complete  # This will create complete_todo_path
    end
    collection do
      get "completed"  # This will create completed_todos_path
    end
  end
  
  resources :users, only: [:new, :create] do
    collection do
      get 'profile', to: 'users#profile'          # profile_users_path
      delete 'destroy_account', to: 'users#destroy_account'  # destroy_account_users_path
    end
  end
  resources :categories
  resources :todos
end