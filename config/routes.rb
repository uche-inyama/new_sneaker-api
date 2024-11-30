Rails.application.routes.draw do 
  devise_for :admins

  devise_for :users, :controllers => { 
    :registrations => "api/v1/registrations",
    :sessions => "api/v1/sessions"
  }

  resources :products do
    resources :samples
  end
  resources :payments, only: [:new, :create, :index]
  post 'cart/:product_id/add', to: 'cart#add'
  delete 'cart/:id/remove', to: 'cart#destroy'

  post 'payments/create_payment_intent', to: 'payments#create_payment_intent'
  post '/webhooks/stripe', to: 'webhooks#stripe'

  unauthenticated do
    devise_scope :admin do
      root "devise/sessions#new", as: :unauthenticated_user
    end
  end
  authenticated  :admin do
    root to: "products#index", as: :authenticated_root
  end
end
