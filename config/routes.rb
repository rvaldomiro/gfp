# -*- encoding : utf-8 -*-
Gfp::Application.routes.draw do

  root to: "home#index"
  
  resource :sessions
  resources :usuarios

  match "delete_usuario" => "usuarios#destroy"

  get  "password_reset/new"
  get  "password_reset/edit"
  post "password_reset/create"

end