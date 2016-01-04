Rails.application.routes.draw do
  root to: 'posts#index'

  get "/recipes", to: redirect('/', status: 301)
  get "/home(/:page)", to: redirect('/', status: 301)

  resources :recipes, only: [:new, :show, :create, :update, :edit] do
    resources :comments, only: [:new, :create]
  end

  resources :content, only: [:show, :edit, :update] do
    resources :comments, only: [:new, :create]
  end

  resources :tags, only: [:show]

  # devise_for :users, controllers: { sessions: "users/sessions" }
  devise_for :users, :controllers => { registrations: 'users/registrations' }
end
