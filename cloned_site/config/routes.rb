Rails.application.routes.draw do
  get 'image_uploads/new'
  get 'image_uploads/create'
  get 'static/home'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
root to: "static#home"
  get "imageupload"=> "image_uploads#new"
  # Defines the root path route ("/")
  # root "posts#index"

resources :image_uploads, only: [:new, :create, :index]

end
