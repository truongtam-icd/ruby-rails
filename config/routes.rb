Rails.application.routes.draw do
  root :to => 'home#index', :as => 'home'

  match 'register', :to => 'register#index', :as => 'register', :via => [:post, :get]
  match 'login', :to => 'account#login', :as => 'login', :via => [:post, :get]
  match 'logout', :to => 'account#logout', :as => 'logout', :via => [:post]
  match 'token', :to => 'account#token', :as => 'token', :via => [:post]
  match 'user/:id', :to => 'account#user', :as => 'user', :via => [:get, :post]
end
