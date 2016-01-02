Rails.application.routes.draw do
  root to: 'posts#index'

  get "/content(/:id)", controller: :posts, action: 'show' #Redirect legacy urls
  # get ":id", controller: :posts, action: 'show'

  resources :posts, only: [:new, :create, :index, :update, :edit] do
    resources :comments, only: [:new, :show, :create, :index, :edit]
  end
end
