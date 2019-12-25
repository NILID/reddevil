Rails.application.routes.draw do
  resources :substrates do
    resources :subfiles, only: %i[new create destroy]
    member do
      post :follow
      get :copy
      get :changes
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

  resources :events, only: %i[list] do
    collection do
      get 'list'
    end
  end

  scope 'sport' do
    resources :rounds do
      collection do
        get :list
      end
      member {get :download}
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

  resources :messages

  %w[404 422 500].each do |code|
    get code, to: 'errors#show', code: code
  end

  resources :notes

  resources :categories

  resources :docs

  resources :users, only: %i[index show edit update] do
    member do
      post 'make_role'
      get 'edit_roles'
    end
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
      get :days_birth
    end
    member do
      get :manage_holidays
      patch :update_holidays
    end
  end

  get 'infocenter/operative' => 'main#operative', as: :operative
  get 'infocenter/project'   => 'main#project'  , as: :project
  get 'infocenter/problem'   => 'main#problem'  , as: :problem

  get 'calendar' => 'main#calendar'
  get 'new_calendar' => 'main#new_calendar'
  get 'relax' => 'main#relax'
  get 'infocenter' => 'main#infocenter', as: :infocenter
  post 'import' => 'main#import'
  get 'nextsong' => 'main#nextsong'

  root to: 'main#index'


end
