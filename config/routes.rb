Rails.application.routes.draw do
  root to: 'recipes#index'

  get "/content(/:id)", to: redirect('/recipes/%{id}')
  get "/recipes", to: redirect('/', status: 301)
  get "/home(/:page)", to: redirect('/', status: 301)
  # get ":id", controller: :recipes, action: 'show'

  resources :recipes, only: [:new, :show, :create, :update, :edit] do
    resources :comments, only: [:new, :create]
  end

  # devise_for :users, controllers: { sessions: "users/sessions" }
  devise_for :users, :controllers => { registrations: 'users/registrations' }
end
