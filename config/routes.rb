Rails.application.routes.draw do
  namespace :client do

    get 'recipes' => 'recipes#index'
    get 'recipes/new' => 'recipes#new'
    post 'recipes' => "recipes#create"   
    get 'recipes/:id' => 'recipes#show'
  end
end
