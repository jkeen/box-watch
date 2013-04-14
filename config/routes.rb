require 'sidekiq/web'

BoxWatch::Application.routes.draw do
  resources :incoming_mails
  resources :shipments

  mount Sidekiq::Web, at: "/sidekiq"

  match '/:tracking_number' => 'shipments#show'
  root :to => "shipments#new"
end
