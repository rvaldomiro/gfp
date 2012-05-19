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
				update_session_user(@usuario)
				redirect_to session[:requested_url] || root_path
			else
				@email = @session.login_name
				redirect_to new_sessions_path, :notice => "Credenciais inválidas!"
			end
		else
			render :new
		end
	end

	def destroy
		remove_session_user
		redirect_to new_sessions_path
	end

end
