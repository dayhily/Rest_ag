Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'properties#index'
  resources :properties do
    resources :images, only: %i[create destroy]
    get 'search', on: :collection
  end
  resource :contacts, only: %i[new create], path_names: { new: '' }
  get 'about' => 'pages#about'
end
