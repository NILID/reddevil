Birthday::Application.routes.draw do

  resources :machines do
    resources :tasks
  end

  resources :substrates do
    member do
      get :remote_show
      get :get_form
    end
    collection do
      get :mirrors
      post :sort
    end
  end

  resources :years do
    resources :columns
    resources :purchases do
      member do
        get :get_form
        get :get_miniform
        get :get_delivery_form
        post :new_form
      end
    end
  end

  resources :subscribes, path: 'phonebook' do
    collection do
      post :import
      get :favorites
    end
    member { post :like }
  end

  resources :events, only: [:list] do
    collection do
      get 'list'
    end
  end

  scope 'sport' do
    resources :rounds do
      member {get :download}
      resources :matches do
        member do
          get :get_results
        end
      end
    end
    resources :users do
      resources :forecasts, except: [:index, :show]
      resources :results, except: [:show, :index] do
        member do
          post 'counted'
        end
      end
    end

    resources :types
    resources :teams

    post 'rebuild_results' => 'results#rebuild'
  end

  resources :messages


  %w(404 422 500).each do |code|
    get code, to: 'errors#show', code: code
  end

  resources :notes


  resources :categories


  resources :docs


  resources :sources


  resources :arts do
    resources :works, except: [:index, :show]
  end

  resources :items

  resources :materials

  resources :users, only: [:index] do
    member do
      post 'make_role'
      get 'edit_roles'
    end
    resource :profile, only: [:edit, :update, :show]
    resources :events
    resources :folders do
      resources :datasets
    end
  end

  resources :albums do
    collection do
      get 'favorites'
    end
    member do
      get 'list'
      post 'like'
      get 'download'
    end
    resources :songs, except: [:edit, :update, :show, :index] do
      member do
        post 'like'
        get 'download'
      end
    end
  end

  resources :members, except: [:show] do
    collection do
      get :archive
      get :stat
      get :holidays
      get :get_holidays
    end
    member do
      get :manage_holidays
    end
  end

  get 'calendar' => 'main#calendar'
  get 'relax' => 'main#relax'
  get 'mirror' => 'main#mirror'
  post 'import' => 'main#import'
  get 'nextsong' => 'main#nextsong'

  root to: "main#index"

  devise_for :users

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
  #     #     resources :sales do
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
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
