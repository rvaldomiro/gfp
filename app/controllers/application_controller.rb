# -*- encoding : utf-8 -*-
class ApplicationController < ActionController::Base
  	
  	protect_from_forgery
  	
  	before_filter :need_login, unless: -> { 
      controller_name == "sessions" || 
      controller_name == "usuarios" && (action_name == "new" || action_name == "create" || action_name == "destroy") ||
      controller_name == "password_reset"
    }

    protected

    def need_login
      unless already_logged_in?
        session[:requested_url] = request.url
        redirect_to sign_in_path 
      end
    end

    def already_logged_in?
      !session[:user].nil?
    end

    def session_user
      session[:user]
    end

    def update_session_user(user)
      unless already_logged_in?
        session[:last_login] = user.ultimo_acesso
        user.password_reset_token = nil
        user.ultimo_acesso = Time.now
        user.save
      end

      session[:user] = user      
    end

    def remove_session_user
      session[:user] = nil
      session[:requested_url] = nil;
      session[:last_login] = nil;       
    end

end
