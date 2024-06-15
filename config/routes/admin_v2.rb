devise_for :admin_users, path: :admin_v2, module: :admin_v2

namespace :admin_v2 do
  root to: 'dashboard#show'
  resource :dashboard, only: :show, controller: :dashboard

  resources :flags, only: %i[index show update]
  resources :announcements
end
