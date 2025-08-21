Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "home#index"
  
  # Blog routes
  get "blog", to: "blog#index"
  get "blog/new", to: "blog#new"
  post "blog", to: "blog#create"
  get "blog/:id", to: "blog#show", as: "blog_post"
  get "blog/:id/edit", to: "blog#edit", as: "edit_blog_post"
  patch "blog/:id", to: "blog#update"
end
