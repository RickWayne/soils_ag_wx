SoilsAgWx::Application.routes.draw do
  resources :regions

  resources :degree_day_stations

  get "heartbeat/index"
  get "heartbeat/awon"
  get "heartbeat/asos"
  get "heartbeat/hyd"
  get "heartbeat/dd"
  get "heartbeat/et"
  get "heartbeat/insol"
  get "heartbeat/ping"
  get "heartbeat/webapps"
  get "heartbeat/asos_grids"
  match "/heartbeat", to: "heartbeat#index", via: [:get, :post]
  resources :hyds

  resources :wi_mn_d_ave_vaprs

  resources :asos_stations

  resources :asos_data

  resources :wi_mn_d_min_t_airs

  resources :wi_mn_d_max_t_airs

  resources :wi_mn_d_ave_t_airs

  resources :awon_record_types

  resources :awon_field_descrips

  get "cranberry/index"
  get "cranberry/summary"
  get "awon/awon_check_boxes"
  get "awon/select_data"
  get "awon/station_info"
  get "awon/graphs"
  get "awon/graphs_soiltemp"
  get "awon/blog"
  get "awon/awon_seven_day"
  match "/awon", to: "awon#index", via: [:get, :post]
  post "awon/download_data"
  get "thermal_models/index"
  get "thermal_models/degree_days"
  get "thermal_models/corn"
  get "thermal_models/corn_dev"
  get "thermal_models/ecb"
  get "thermal_models/alfalfa"
  get "thermal_models/corn_stalk_borer"
  get "thermal_models/potato"
  get "thermal_models/tree"
  get "thermal_models/gypsy"
  get "thermal_models/gypsyinfo"
  get "thermal_models/scm"
  get "thermal_models/wiDDs"
  get "thermal_models/wiDDs_csv"
  get "thermal_models/westernbeancutworm"
  get "thermal_models/scm_doc"
  get "thermal_models/remaining_dds"
  get "thermal_models/remaining_dd_map_for"
  get "thermal_models/frost_map"
  get "thermal_models/many_degree_days_for_date"
  post "thermal_models/get_dds_many_locations"
  get "thermal_models/get_dds_many_locations"
  match "/thermal_models", to: "thermal_models#index", via: [:get, :post]
  get "sun_water/index"
  get "sun_water/insol_east_us"
  get "sun_water/insol_west_us"
  get "sun_water/insol_model"
  get "sun_water/et_wimn"
  get "sun_water/et_fl"
  get "sun_water/et_model"
  get "sun_water/spreadsheet_download"
  get "sun_water/spreadsheet_doc"
  get "sun_water/grid_ets"
  post "sun_water/get_grid"
  match "/sun_water", to: "sun_water#index", via: [:get, :post]
  get "subscribers/send_emails/:id" => "subscribers#send_emails"
  post "subscribers/send_special"
  get "weather/index"
  get "weather/hyd"
  get "weather/awon"
  get "weather/grid_temps"
  get "weather/webcam"
  get "weather/doycal"
  get "weather/doycal_grid"
  post "weather/get_grid"
  post "wi_mn_dets/get_grid"
  post "thermal_models/get_dds"
  get "navigation/index"
  get "navigation/about"
  match "/navigation", to: "navigation#index", via: [:get, :post]
  resources :t401s

  resources :t406s

  resources :t403s

  resources :t412s

  resources :awon_stations

  resources :wi_mn_dets

  resources :products

  resources :subscriptions

  resources :subscribers

  resources :blogs

  get "t411s/last"
  resources :t411s
  
  root to: 'navigation#index'

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
