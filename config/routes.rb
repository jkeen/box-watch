PackageTracker::Application.routes.draw do
  resources :incoming_mails
  resources :shipments
  match 'track/:tracking_number' => 'shipments#show'
  # root :to => "welcome#index"
end
