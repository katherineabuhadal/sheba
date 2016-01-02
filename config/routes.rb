Rails.application.routes.draw do
  root to: 'posts#index'

  get "/content(/:id)", controller: :posts, action: 'show' #Redirect legacy urls
  # get ":id", controller: :posts, action: 'show'

  resources :posts, only: [:new, :show, :create, :index, :update, :edit] do
    resources :comments, only: [:new, :create]
  end
end
