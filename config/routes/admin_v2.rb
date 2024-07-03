devise_for :admin_users, path: :admin_v2, module: :admin_v2

namespace :admin_v2 do
  root to: 'dashboard#show'
  resource :dashboard, only: :show, controller: :dashboard

  resources :flags, only: %i[index show update]
  resources :announcements
  resource :team, only: :show, controller: :team

  resources :team_members do
    resources :password_resets, only: %i[create], controller: 'team_members/password_resets'
  end

  resource :profile, only: %i[edit update], controller: :profile do
    resource :password, only: %i[update], controller: 'profile/password'
  end
end
