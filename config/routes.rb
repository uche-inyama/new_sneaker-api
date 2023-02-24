Rails.application.routes.draw do
  devise_for :users, :controllers => { 
    :registrations => "api/v1/registrations",
    :sessions => "api/v1/sessions"
  }

  unauthenticated do
    devise_scope :user do
      root to: "api/v1/sessions#new"
    end
  end
  resources :products
end
