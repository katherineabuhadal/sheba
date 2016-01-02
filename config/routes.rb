Rails.application.routes.draw do
  root to: 'recipes#index'

  get "/content(/:id)", controller: :recipes, action: 'show' #Redirect legacy urls
  # get ":id", controller: :recipes, action: 'show'

  resources :recipes, only: [:new, :show, :create, :index, :update, :edit] do
    resources :comments, only: [:new, :create]
  end
end
