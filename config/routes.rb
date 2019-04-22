Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users, only: %i[create] do
        post 'profile', on: :collection
      end
      resources :groups, only: :create do
        post 'add_users', on: :member
      end
      post '/login', to: 'auth#create'
    end
  end
end
