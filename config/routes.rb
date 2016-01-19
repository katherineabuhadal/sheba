Rails.application.routes.draw do
  root to: 'posts#index'

  resources :recipes, only: [:new, :show, :create, :update, :edit] do
    resources :comments, only: [:new, :create]
  end

  resources :content, only: [:show, :edit, :update] do
    resources :comments, only: [:new, :create]
  end

  resources :comments, only: [] do
    resources :comments, only: [:create]
  end

  resources :tags, only: [:show]

  devise_for :users, :controllers => { registrations: 'users/registrations' }

  get 'contact', to: 'messages#new', as: 'contact'
  resources :messages, only: [:create]

  get "/home(/:page)", to: redirect('/', status: 301)
  get "/recipes", to: redirect('/', status: 301)
  get "/ingredients", to: redirect('/', status: 301)
  get "/meals/breakfast", to: redirect('/tags/breakfast', status: 301)
  get "/meals/dessert", to: redirect('/tags/dessert', status: 301)
  get "/meals/dinner", to: redirect('/tags/dinner', status: 301)
  get "/meals/snacks", to: redirect('/tags/snacks', status: 301)
  get "/breads", to: redirect('/tags/breads', status: 301)

end
