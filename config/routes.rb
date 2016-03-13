Rails.application.routes.draw do

  devise_for :admins
  root to: "match#new"

  get 'admins' => 'admin#index'
  delete 'admins/:id' => 'admin#destroy'
  post 'admins/new' => 'admin#new'

  get 'match' => 'match#new'
  get 'matches' => 'match#index'

  get 'teachers/new' => 'teacher#new'
  post 'teachers' => 'teacher#create'

  get 'scientists/new' => 'scientist#new'
  post 'scientists' => 'scientist#create'

  get 'teachers/test' => 'teacher#test'
  get 'scientists/test' => 'scientist#test'

  get 'matches/new' => 'match#new'
  get 'matches/get_matched_teachers/:id' => 'match#get_matched_teachers'
  get 'matches/get_matched_scientists/:id' => 'match#get_matched_scientists'
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
