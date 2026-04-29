Rails.application.routes.draw do
  root "landing#index"
  get "faq", to: "faq#index"
  get "/auth/hackclub", to: "hca_auth#redirect", as: :auth_hackclub
  get "/hca/auth/callback", to: "hca_auth#callback", as: :auth_callback
  get "/auth/signout", to: "hca_auth#signout", as: :auth_signout

  get "/auth/hackatime", to: "hackatime_auth#redirect", as: :auth_hackatime
  get "hackatime/auth/callback", to: "hackatime_auth#callback", as: :auth_hackatime_callback
  get "home", to: "home#index", as: "home"
  resources :projects, except: [:new, :show]

  get "/shop", to: "shop#index", as: "shop"
  post "/shop", to: "shop#create"
  get "/shop/my_orders", to: "shop#orders", as: "orders"

  resources :items
  resources :explore



  # get "/auth/lapse", to: "lapse_auth#redirect", as: :auth_lapse
  # get "/lapse/auth/callback", to: "lapse_auth#callback", as: :auth_lapse


  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end
