Rails.application.routes.draw do
  resources :manufacture_groups, except: [:index]

  resources :operations
  resources :manufactures do
    member do
      get :manage_otk
      delete :delete_document
    end
  end

  resources :departments, except: [:show]

  resources :office_notes do
    member do
      delete :delete_document
    end
  end

  resources :pages, path: 'wiki'

  resources :tables do
    resources :rows, except: [:index, :show] do
      collection do
        post :sort
      end

      member do
        get :get_form
        get :get_miniform
        post :new_form
      end
    end
  end

  resources :substrates do
    resources :subfiles, only: %i[new create destroy]
    member do
      post :follow
      get :copy
      get :changes
      get :manage_otk
      delete :delete_document
    end
    collection do
      get :history
      get :archive
    end
  end

  scope 'chat' do
    resources :room_messages, only: [:create]
    resources :rooms
  end
  resources :vacations, only: [:index]
  resources :notes

  devise_for :users

  resources :events, only: [] do
    collection do
      get 'list'
    end
  end

  scope 'sport' do
    resources :rounds do
      collection do
        get :list
      end

      member { get :download }

      resources :matches, only: %i[destroy] do
        member do
          get :get_results
        end
      end
    end
    resources :users, only: [] do
      resources :forecasts, except: %i[index show]
      resources :results, except: %i[show index] do
        member do
          post 'counted'
        end
      end
    end

    resources :types
    resources :teams

    post 'rebuild_results' => 'results#rebuild'
  end

  resources :messages, except: [:show]

  %w[404 422 500].each do |code|
    get code, to: 'errors#show', code: code
  end

  resources :notes

  resources :categories

  resources :infocenter_categories, path: :infocenter do
    resources :cards, except: [:show, :index]

    collection do
      get :manage
      post :sort
    end

    member do
      get :add_table
    end
  end

  resources :docs do
    collection do
      get :archive
    end
    member do
      post :follow
      put :toggle_archive
      get :open
    end
  end

  resources :users, only: %i[index show edit update] do
    member do
      post 'make_role'
      get 'edit_roles'
    end
    resources :events
    resources :folders do
      resources :datasets, except: [:index, :show]
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
    resources :songs, except: %i[edit update show index] do
      member do
        post 'like'
        get 'download'
      end
    end
  end

  resources :positions, only: [] do
    collection do
      get :career
    end
  end

  resources :members, except: %i[show] do
    collection do
      get :archive
      get :stat
      get :days_birth
    end

    resources :positions, except: %[show]
    resources :vacations, except: %[show] do
      collection do
        get :list
      end
    end
  end

  get 'infocenter/operative' => 'main#operative', as: :operative
  get 'infocenter/project'   => 'main#project'  , as: :project
  get 'infocenter/problem'   => 'main#problem'  , as: :problem
  get 'infocenter/security'  => 'main#security',  as: :security
  get 'infocenter/quality'   => 'main#quality',   as: :quality
  get 'infocenter/orders'    => 'main#orders',    as: :orders
  get 'infocenter/expenses/personal'  => 'main#personal',  as: :personal
  get 'infocenter/expenses/products'  => 'main#products',  as: :products
  get 'infocenter/corporate/strength' => 'main#strength', as: :strength
  get 'infocenter/corporate/salary'   => 'main#salary',   as: :salary
  get 'infocenter/corporate/vac' => 'main#vac', as: :vac

  get 'calendar' => 'main#calendar'
  get 'new_calendar' => 'main#new_calendar'
  get 'relax' => 'main#relax'
  get 'infocenter' => 'main#infocenter'#, as: :infocenter
  post 'import' => 'main#import'
  get 'nextsong' => 'main#nextsong'

  root to: 'main#index'


end
