# rubocop:disable Lint/MissingCopEnableDirective, Metrics/BlockLength
Rails.application.routes.draw do
  draw(:redirects)
  ActiveAdmin.routes(self)

  require 'sidekiq/web'
  authenticate :user, ->(user) { user.admin? } do
    mount Sidekiq::Web => '/sidekiq'
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
    get '/sign_out' => 'users/sessions#destroy', method: :delete
    get '/sign_up' => 'users/registrations#new'
  end

  namespace :api do
    resources :lesson_completions, only: [:index]
    resources :points, only: %i[index show create]
  end

  get 'home' => 'static_pages#home'
  get 'about' => 'static_pages#about'
  get 'faq' => 'static_pages#faq'
  get 'contributing' => 'static_pages#contributing'
  get 'terms_of_use' => 'static_pages#terms_of_use'
  get 'success_stories' => 'static_pages#success_stories'
  get 'community_rules' => 'static_pages#community_rules'
  get 'community_expectations' => 'static_pages#community_expectations'
  get 'before_asking' => 'static_pages#before_asking'
  get 'how_to_ask' => 'static_pages#how_to_ask'
  get 'sitemap' => 'sitemap#index', defaults: { format: 'xml' }

  # failure route if github information returns invalid
  get '/auth/failure' => 'omniauth_callbacks#failure'
  get 'dashboard' => 'users#show', as: :dashboard

  namespace :users do
    resources :paths, only: :create
    resources :progress, only: :destroy
    resource :profile, only: %i[edit update]
  end

  namespace :lessons do
    resource :preview, only: %i[show create]
    resources :installation_lessons, only: %i[index]
  end

  namespace :courses do
    resources :progress, only: %i[show]
  end

  resources :lessons, only: :show do
    resources :project_submissions, only: %i[index], controller: 'lessons/project_submissions'

    resources :lesson_completions, only: %i[create], as: 'completions'
    delete 'lesson_completions' => 'lesson_completions#destroy', as: 'lesson_completions'
  end

  resources :project_submissions do
    resources :flags, only: %i[create], controller: 'project_submissions/flags'
    resources :likes, controller: 'project_submissions/likes'
  end

  resources :paths, only: %i[index show] do
    resources :courses, only: :show
  end

  resources :notifications, only: %i[index update]
  resource :themes, only: :update

  match '/404' => 'errors#not_found', via: %i[get post patch delete]
end
