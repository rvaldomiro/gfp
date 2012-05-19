# -*- encoding : utf-8 -*-
class ApplicationController < ActionController::Base
  	
  	protect_from_forgery
  	
  	before_filter :need_login, unless: -> { 
      controller_name == "sessions" || 
      controller_name == "usuarios" && (action_name == "new" || action_name == "create") ||
      controller_name == "passwords"
    }

    protected

    def need_login
      unless already_logged_in?
        session[:requested_url] = request.url
        redirect_to new_sessions_path 
      end
    end

    def already_logged_in?
      !session[:user].nil?
    end

    def session_user
      session[:user]
    end

    def update_session_user(user)
      session[:user] = user
    end

    def remove_session_user
      session[:user] = nil
    end

end
