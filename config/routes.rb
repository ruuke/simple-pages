Rails.application.routes.draw do
  resources :pages, path: "", path_names: { new: 'add' }
end
