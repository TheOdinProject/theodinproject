devise_for :admin_users, path: :admin_v2, module: :admin_v2

namespace :admin_v2 do
  root to: 'dashboard#show'
  resource :dashboard, only: :show, controller: :dashboard

  resources :flags, only: %i[index show update]
  resources :announcements
  resource :team, only: :show, controller: :team

  resources :team_members do
    resources :password_resets, only: %i[create], controller: 'team_members/password_resets'
    resource :resend_invitation, only: %i[create], controller: 'team_members/resend_invitation'
    resource :deactivation, only: %i[update], controller: 'team_members/deactivation'
    resource :reactivation, only: %i[update], controller: 'team_members/reactivation'
  end

  resource :profile, only: %i[edit update], controller: :profile do
    resource :password, only: %i[update], controller: 'profile/password'
  end

  namespace :reports do
    resource :lesson_completions, only: :show
    resources :paths, only: :show
    resources :users, only: :index
  end
end
