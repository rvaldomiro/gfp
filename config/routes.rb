# -*- encoding : utf-8 -*-
Gfp::Application.routes.draw do

  root to: "home#index"
  
  resource :sessions
  resources :usuarios

  match "sign_in" => "sessions#new"
  match "sign_up" => "usuarios#new"  
  match "profile_edit" => "usuarios#edit"
  match "profile_delete" => "usuarios#destroy"

  get  "password_reset/new"
  get  "password_reset/edit"
  post "password_reset/create"

end
