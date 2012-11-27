Nama::Application.routes.draw do

  resources :users
  match '/create_activation',
    to: 'static_pages#create_activation', :via => :post

  match '/activate_user/:user_id/:activation_token',
    to: 'static_pages#activate_user', :via => :get

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

  resources :sessions, only: [:new, :create, :destroy]
  match '/signin', to: 'sessions#new'
  match '/signout', to: 'sessions#destroy', via: :delete

  root to: 'sessions#new'

  match '/signup',  to: 'static_pages#signup'
  match '/about',   to: 'static_pages#about'
  match '/contact', to: 'static_pages#contact'
  match '/help',    to: 'static_pages#help'
end
