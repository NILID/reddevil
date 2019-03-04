Rails.application.routes.draw do
  resources :vacations, only: [:index]
  resources :notes
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

  resources :events, only: %i[list] do
    collection do
      get 'list'
    end
  end

  scope 'sport' do
    resources :rounds do
      member {get :download}
      resources :matches, only: %i[destroy] do
        member do
          get :get_results
        end
      end
    end
    resources :users do
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

  resources :messages

  %w[404 422 500].each do |code|
    get code, to: 'errors#show', code: code
  end

  resources :notes

  resources :categories

  resources :docs

  resources :users, only: %i[index] do
    member do
      post 'make_role'
      get 'edit_roles'
    end
    resource :profile, only: %i[edit update show]
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
    resources :songs, except: %i[edit update show index] do
      member do
        post 'like'
        get 'download'
      end
    end
  end

  resources :members, except: %i[show] do
    collection do
      get :archive
      get :stat
      get :holidays
    end
    member do
      get :manage_holidays
      patch :update_holidays
    end
  end

  get 'calendar' => 'main#calendar'
  get 'relax' => 'main#relax'
  get 'mirror' => 'main#mirror'
  post 'import' => 'main#import'
  get 'nextsong' => 'main#nextsong'

  root to: 'main#index'

  devise_for :users
end
