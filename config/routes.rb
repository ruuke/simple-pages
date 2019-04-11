Rails.application.routes.draw do
  root 'pages#index'

  get '/add', to: 'pages#new'

  # routes for nested pages
  get '/*slug/add', to: 'pages#new', as: :new_subpage
  get '/*slug/edit', to: 'pages#edit', as: :edit_subpage
  get '/*slug', to: 'pages#show', as: :subpage
  patch '/*slug', to: 'pages#update'
  put '/*slug', to: 'pages#update'
  delete '/*slug', to: 'pages#destroy'

  # routes for root pages
  resources :pages, path: "", path_names: { new: 'add' }, except: [:update]
end
