# rubocop:disable Lint/MissingCopEnableDirective, Metrics/BlockLength
Rails.application.routes.draw do
  match '/404' => 'errors#not_found', via: :all
  match '422' => 'errors#unprocessable_entity', via: :all
  match '500' => 'errors#internal_server_error', via: :all

  draw(:redirects)
  draw(:admin_v2)
  ActiveAdmin.routes(self)

  require 'sidekiq/web'
  authenticate :user, ->(user) { user.admin? } do
    mount Sidekiq::Web => '/sidekiq'
    mount Flipper::UI.app(Flipper) => 'admin/feature_flags', as: :admin_feature_flags
  end

  if Rails.env.development?
    mount Lookbook::Engine, at: '/lookbook'
  end

  resource :github_webhooks, only: :create, defaults: { formats: :json }

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

  namespace :api do
    resources :lesson_completions, only: [:index]
    resources :points, only: %i[index show create]
  end

  get 'home' => 'static_pages#home'
  get 'about' => 'static_pages#about'
  get 'faq' => 'static_pages#faq'
  get 'team' => 'static_pages#team'
  get 'contributing' => 'static_pages#contributing'
  get 'support_us' => 'static_pages#support_us'
  get 'terms_of_use' => 'static_pages#terms_of_use'
  get 'privacy-policy' => 'static_pages#privacy_policy'
  get 'success_stories' => 'static_pages#success_stories'
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
end
