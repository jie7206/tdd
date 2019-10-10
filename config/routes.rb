Rails.application.routes.draw do

  get 'tasks/edit'
  get 'tasks/update'
  get 'tasks/destroy'
  root "projects#index"
  resources :projects
  resources :tasks

end
