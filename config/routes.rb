SimpleSupport::Application.routes.draw do
  devise_for :users

  namespace :admin do
    root :to => "discussions#index"
    resources :discussions
  end
  
  resources :discussions
  
  root :to => "discussions#index"
end
