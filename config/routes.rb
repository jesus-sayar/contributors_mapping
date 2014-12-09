Rails.application.routes.draw do
  # BACKEND
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  # FRONTEND
  root to: "dashboards#show"
  resource :dashboard, only: :show
  resources :projects, only: [:create] do
    collection { get :random }
  end
  get ':username/:repo' => "projects#show", as: :project
end
