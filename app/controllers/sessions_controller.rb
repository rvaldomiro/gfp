# -*- encoding : utf-8 -*-
class SessionsController < ApplicationController

	def new
		@session = Session.new
	end

	def create
		@session = Session.new(params[:session])

		if @session.valid?
			@usuario = Usuario.login(@session.login_name, @session.password)

			if @usuario
				session[:usuario] = @usuario
				redirect_to session[:requested_url] || root_path
			else
				redirect_to new_sessions_path, :notice => "Usuário e/ou Senha inválidos!"
			end
		else
			render :new
		end
	end

	def destroy
		session[:usuario] = nil
		redirect_to new_sessions_path
	end

end
