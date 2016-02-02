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
  get "/meals/sweets", to: redirect('/tags/sweets', status: 301)
  get "/lunch", to: redirect('/tags/lunch', status: 301)
  get "/breads", to: redirect('/tags/breads', status: 301)
  get "/spices/yemeni-cooking", to: redirect('/tags/spices', status: 301)
  get "/spices/yemeni-salta", to: redirect('/content/saltah', status: 301)
  get "/spices/yemeni-food", to: redirect('/yemeni-food', status: 301)
  get "/spices/yemeni-cooking", to: redirect('/tags/yemeni-cooking', status: 301)
  get "/spices/turmeric", to: redirect('/tags/turmeric', status: 301)
  get "/spices/cumin", to: redirect('/tags/cumin', status: 301)
  get "/spices/cloves", to: redirect('/tags/cloves', status: 301)
  get "/spices/black-cumin-seeds", to: redirect('/tags/black-cumin-seeds', status: 301)
  get "/content/fatah", to: redirect('/content/susi-fattah', status: 301)
  get "/spices/zurbiyan", to: redirect('/', status: 301)
  get "/blog", to: redirect('/', status: 301)
  get "/lunch/saltah", to: redirect('/content/saltah', status: 301)
  get "/spices/%D8%A8%D9%86%D8%AA-%D8%A7%D9%84%D8%B5%D8%AD%D9%86", to: redirect('/tags/%D8%A8%D9%86%D8%AA-%D8%A7%D9%84%D8%B5%D8%AD%D9%86', status: 301)


end
