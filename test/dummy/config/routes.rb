Dummy::Application.routes.draw do
  get '*path', :to => 'application#index'
  root :to => 'application#index'
end
