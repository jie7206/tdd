Rails.application.routes.draw do

  root "projects#index"
  resources :projects
  resources :tasks do
    member do
      get :update_tdd_step, :set_as_top_task, :cancel_top_task
    end
  end

end
