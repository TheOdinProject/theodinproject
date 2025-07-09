# rubocop:disable Lint/MissingCopEnableDirective, Metrics/BlockLength
Rails.application.routes.draw do
  match '/404' => 'errors#not_found', via: :all
  match '422' => 'errors#unprocessable_entity', via: :all
  match '500' => 'errors#internal_server_error', via: :all

  draw(:redirects)

  if Rails.env.development?
    mount Lookbook::Engine, at: '/lookbook'
  end

  unauthenticated do
    root 'static_pages#home'
  end

  authenticated :user do
    root to: redirect('/dashboard'), as: :authenticated_root
  end

  devise_for(
    :users,
    module: 'users',
    controllers: { passwords: 'users/password_resets' },
    path_names: { password: 'password_reset' }
  )

  devise_scope :user do
    get '/sign_in' => 'users/sessions#new'
    delete '/sign_out' => 'users/sessions#destroy'
    get '/sign_up' => 'users/registrations#new'
  end

  namespace :github do
    resource :webhooks, only: :create, defaults: { formats: :json }
  end

  namespace :api do
    resources :points, only: %i[index show create]
  end

  scope controller: :static_pages do
    get 'home'
    get 'about'
    get 'faq'
    get 'team'
    get 'contributing'
    get 'support_us'
    get 'terms_of_use'
    get 'privacy-policy'
    get 'success_stories'
  end

  get 'sitemap' => 'sitemap#index', defaults: { format: 'xml' }

  namespace :guides do
    resources :installations, only: :index
    resource :community, only: :show, controller: 'community' do
      collection do
        get :before_asking
        get :how_to_ask
        get :expectations
        get :rules
      end
    end
  end

  # failure route if github information returns invalid
  get '/auth/failure' => 'users/omniauth_callbacks#failure'
  get 'dashboard' => 'users#show', as: :dashboard

  namespace :users do
    resources :paths, only: :create
    resources :progress, only: :destroy
    resource :profile, only: %i[edit update]
  end

  namespace :lessons do
    resource :preview, only: %i[show create] do
      resource :share, only: %i[create], controller: 'previews/share'
    end
  end

  namespace :courses do
    resources :progress, only: %i[show]
  end

  resources :lessons, only: :show do
    resources :project_submissions, except: :show, controller: 'lessons/project_submissions'
    resource :completion, only: %i[create destroy], controller: 'lessons/completions'
  end

  resources :project_submissions, only: :index do
    resources :flags, only: %i[new create], controller: 'project_submissions/flags'
    resource :like, only: %i[update], controller: 'project_submissions/likes'
  end

  resources :paths, only: %i[index show] do
    resources :courses, only: :show
  end

  resources :notifications, only: %i[index update]
  resource :themes, only: :update
  resources :interview_surveys, only: %i[new create]

  draw(:admin)

  get 'approval' => 'admin/approvals#index', as: :admin_approval

  namespace :admin do
    resources :approvals, only: %i[index show] do
      member do
        patch :approve
        patch :reject
      end
    end
  end

  resources :lessons do
    patch :mark_complete, on: :member
  end
end
