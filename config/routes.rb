Notable::Application.routes.draw do

  devise_for :users, :controllers => { :registrations => "registrations"}

  devise_scope :user do
    match '/signin', to: 'devise/sessions#new'
    match '/signup', to: 'devise/registrations#new'
  end

  get "items/create"
  get "reminders/create"
  get "filepickers/create"
  get "notes/sort_by/:criteria", to: 'notes#sort_by', as: :sort_by
  get 'tags/:tag', to: 'notes#filter_by_tags', as: :filter_tag
  get "lasttest/create"

  get "sidebar/select_note/:id", to: "sidebar#select_note", as: :select_note
  get "sidebar/recent_notes", to: "sidebar#recent_notes", as: :recent_notes
  get "sidebar/short_notes", to: "sidebar#short_notes", as: :short_notes
  get "notes/load_tags/:id", to: 'notes#load_tags', as: :load_tags
  get "notes/note_search",to: "notes#note_search", as: :note_search
  put "notes/update_tags/:id/user/:user_id", to: 'notes#update_tags', as: :update_tags
  resources :users
  resources:tags
  resources :notes do 
    collection { post :sort }
  end

  match "/notes/:id" => "notes#duplicate", :via => [:post]
  match '/help',    to: 'static_pages#help'
  match '/about',   to: 'static_pages#about'
  match '/contact', to: 'static_pages#contact'
  match '/settings',to: 'static_pages#settings'
  
  
  
  root :to => "main#home"
  
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
