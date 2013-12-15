Ratebeer::Application.routes.draw do


  resources :styles


  #Beer Mapping
  resources :places, :only => [:index, :show]
  post 'places' => 'places#search'

  # Pääsivu
  root :to => 'breweries#index'

  # Käyttäjät
  resources :users
  get 'signup', to: 'users#new'

  # Sessiot
  resources :sessions, :only => [:new, :create, :destroy]
  get 'signin', to: 'sessions#new'
  delete 'signout', to: 'sessions#destroy'

  # Muut
  resources :memberships, :only => [:new, :create]
  get 'join', to: 'memberships#new'
  resources :memberships do
    post 'confirm', :on => :member
  end

  resources :beer_clubs




  resources :ratings, :only => [:index, :new, :create, :destroy]
  resources :beers
  get 'beerlist' => 'beers#list'

  resources :breweries

  resources :breweries do
    post 'toggle_activity', :on => :member
  end

end
