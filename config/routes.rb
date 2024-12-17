Rails.application.routes.draw do
  devise_for :users
  root to: 'files#index'

  resources :files, path: 'files', only: [:index, :create, :destroy] do
    member do
      get :share
      get :public, to: 'files#public'
    end
  end
  get 'files/:id/public', to: 'files#public', as: 'file_public'
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
