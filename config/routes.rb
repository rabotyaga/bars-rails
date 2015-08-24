Ra::Application.routes.draw do

  #resources :alphabets

  devise_for :users
  resources :articles, only: [:index, :edit, :update, :new, :create, :destroy] do
    # collection { post :import }
    # collection { get :offline }
  end
  root 'index#index'

  get 'search' => 'index#search'
  get 'autocomplete' => 'index#autocomplete'
  get 'blagodarnost' => 'index#blagodarnost'

  get '/m/:path', to: redirect('/%{path}')
  get '/m/', to: redirect('/')
  get '/mobile/:path', to: redirect('/%{path}')
  get '/mobile/', to: redirect('/')

  resources :alphabet, only: [:index]
  resources :about, only: [:index]
  resources :apple_dictionary, only: [:index]

  resources :accounts, only: [:index, :update]
  resources :logs, only: [:index]

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
