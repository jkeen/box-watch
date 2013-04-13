PackageTracker::Application.routes.draw do
  resources :incoming_mails
  resources :shipments

  namespace "admin" do
    match "/overview" => "overview#index"
    match "/overview/:id" => "overview#show"

    root :to => "overview#index"
  end
  
  match '/:tracking_number' => 'shipments#show'
  root :to => "shipments#new"
end
