Rails.application.routes.draw do
  root to: 'recipes#index'

  get "/content(/:id)", to: redirect('/recipes/%{id}')
  get "/recipes", to: redirect('/', status: 301)
  # get ":id", controller: :recipes, action: 'show'

  resources :recipes, only: [:new, :show, :create, :update, :edit] do
    resources :comments, only: [:new, :create]
  end
end
