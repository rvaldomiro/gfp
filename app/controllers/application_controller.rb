# -*- encoding : utf-8 -*-
class ApplicationController < ActionController::Base
  	
  	protect_from_forgery
  	
  	before_filter :need_login, unless: -> { 
      controller_name == 'sessions' || 
      controller_name == 'usuarios' && action_name == 'new' || action_name == 'create' ||
      controller_name == 'welcome'
    }

  	protected

  	def need_login
  		unless already_logged_in?
  			session[:requested_url] = request.url
  			redirect_to new_sessions_path 
  		end
  	end

  	def already_logged_in?
  		!session[:usuario].nil?
  	end

end
