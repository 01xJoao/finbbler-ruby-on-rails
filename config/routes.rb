Rails.application.routes.draw do
  
  root 'posts#index'
  
  get 'relationships/follow_user'
  get 'relationships/unfollow_user'

  get 'profiles/show'
  
  devise_for :users, :controllers => { registrations: 'registrations' }
  match 'users/:id' => 'registrations#destroy', :via => :delete, :as => :admin_destroy_user
  
  resources :posts do
    resources :clothes
    resources :comments
    member do
      get 'like'
    end
  end
  
  post ':user_name/follow_user', to: 'relationships#follow_user', as: :follow_user
  post ':user_name/unfollow_user', to: 'relationships#unfollow_user', as: :unfollow_user
  
  post 'profiles/search', as: 'search_users'
  
  get 'browse', to: 'posts#browse', as: :browse_posts
  
  # Route Existente
  get ':user_name', to: 'profiles#show', as: :profile
  # Nova Route
  get ':user_name/edit', to: 'profiles#edit', as: :edit_profile
  # Route actualizada
  patch ':user_name/edit', to: 'profiles#update', as: :update_profile
end