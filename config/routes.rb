Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    resources :members
    resources :books do
      post 'borrow', on: :collection
      patch 'return', on: :collection
    end
end
