Rails.application.routes.draw do
  root :to => 'home#index', :as => 'home'

  match 'login', :to => 'account#login', :as => 'signin', :via => [:post]
  match 'logout', :to => 'account#logout', :as => 'signout', :via => [:post]

  match 'user/:id', :to => 'account#user', :as => 'user', :via => [:get]
end
