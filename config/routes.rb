Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'users#survey'

  resource :user, except: [:show]

  resource :user, only: [:show] do
    get 'survey' => "users#survey"
    post 'survey' => "users#survey_results"
  end

  get "test" => "tests#new"
  # get 'search' => 'searches#new'


  resources :searches


  resources :searches

  get "/apitest" => "walkscores#show"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # devise_scope :user do
  #   root to: 'devise/registrations#new'
  # end

end
