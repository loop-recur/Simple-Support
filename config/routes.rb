SimpleSupport::Application.routes.draw do
  devise_for :ticket_holders, :class_name => "User::TicketHolder"
  devise_for :admins, :class_name => "User::Admin"

  namespace :admin do
    root :to => "discussions#index"
    resources :buckets
    resources :discussions do
      resources :messages
    end
    resources :agents
    resources :ticket_holders
  end
  

  scope :module => :widgets do
    resources :discussions
    match "router/:masked_id" => "application#route", :as => "widget_router"
  end  
  
  root :to => "widgets/discussions#index"
end
