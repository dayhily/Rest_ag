Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "home#index"
  resources :properties do
    resources :images, :only => [:create, :destroy]
    get 'search', on: :collection
  end
end
