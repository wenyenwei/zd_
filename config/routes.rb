Rails.application.routes.draw do

  resources :customer_bookings
  resources :books
  devise_for :users
  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql"
  end

  post "/graphql", to: "graphql#execute"
  root 'customer_bookings#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
