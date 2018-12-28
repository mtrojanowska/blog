Rails.application.routes.draw do

  get 'articles/index', to: 'articles#index'

  get 'new-article', to: 'articles#new', as: 'new-article'

  get 'articles/create', to: 'articles#create'

  get 'articles/update', to: 'articles#update'

  get 'articles/destroy', to: 'articles#destroy'

  root 'pages#home'
  get 'pages/home', to: 'pages#home'

  get 'pages/about', to: 'pages#about'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
