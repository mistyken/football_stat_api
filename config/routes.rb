Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :upload
  resources :players do
    resources :kickings
    resources :passings
    resources :receivings
    resources :rushings
  end
end
