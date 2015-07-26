Rails.application.routes.draw do
  root to: 'posts#index'
  resources :posts, only: [:new, :show, :create, :index, :update, :edit] do
    resources :comments, only: [:new, :show, :create, :index, :edit]
  end
end
