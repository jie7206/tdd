Rails.application.routes.draw do

  root "projects#index"
  resources :projects
  resources :tasks do
    member do
      get :update_tdd_step
    end
  end

end
