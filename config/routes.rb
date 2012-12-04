Nama::Application.routes.draw do

  resources :users
  match '/create_activation',
    to: 'users#create_activation', :via => :post

  match '/activate_user/:user_id/:activation_token',
    to: 'users#activate_user', :via => :get

  match '/activation_failure', to: 'users#activation_failure'

  resources :groups
  match '/groups/:id/members/:user_id',
    :to => 'groups#add_membership', :via => :post,
    :as => 'group_memberships'

  match '/groups/:id/members/:user_id',
    :to => 'groups#remove_membership', :via => :delete,
    :as => 'group_memberships'

  resources :events do
    resources :timeslots
  end

  match '/events/:event_id/timeslots/:id/duplicate',
    :to => 'timeslots#duplicate', :via => :post,
    :as => 'timeslot_duplicate'

  match '/events/:event_id/timeslots/:id/enroll',
    :to => 'timeslots#enroll', :via => :post,
    :as => 'timeslot_enroll'

  resources :sessions, only: [:new, :create, :destroy]
  match '/signin', to: 'sessions#new'
  match '/signout', to: 'sessions#destroy', via: :delete

  root to: 'sessions#new'

  resources :ratings

  match '/signup', to: 'static_pages#signup'
  match '/home_admin', to: 'static_pages#home_admin'
  match '/home_user', to: 'static_pages#home_user'
  match '/about', to: 'static_pages#about'
  match '/contact', to: 'static_pages#contact'
  match '/help', to: 'static_pages#help'
end
