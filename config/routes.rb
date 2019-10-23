Rails.application.routes.draw do

  get 'sessions/new'
  get 'sessions/create'
  get 'sessions/destroy'
  root "projects#index"
  resources :projects do
    member do
      get :set_all_tasks_completed
    end
  end
  resources :tasks do
    member do
      get :update_tdd_step, :set_as_top_task, :cancel_top_task
    end
  end
  get '/login', to: 'sessions#login'
  get '/logout', to: 'sessions#logout'

end
