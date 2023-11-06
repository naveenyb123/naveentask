Rails.application.routes.draw do
  

    resources :users, only: [:show, :create, :update, :destroy] do
      resources :todos, only: [:index, :show, :create, :update, :destroy]  do
        resources :items, only: [:create, :update, :destroy]     
       end
      end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
