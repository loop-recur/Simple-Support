SimpleSupport::Application.routes.draw do
  devise_for :users

  namespace :admin do
    root :to => "discussions#index"
    resources :discussions
  end
  

  scope :module => :widgets do
    resources :discussions
    match "router/:masked_id" => "application#route", :as => "widget_router"
  end  
  
  root :to => "admin/discussions#index"
end
