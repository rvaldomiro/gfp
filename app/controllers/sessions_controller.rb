# -*- encoding : utf-8 -*-
class SessionsController < ApplicationController

	def new
		@session = Session.new
		usuario = Usuario.find_by_auth_token(cookies[:remember_me]) if cookies[:remember_me]

		if usuario
			@session.login_name = usuario.nome_login
			@session.password = "ztySUlt3b+mKPX3fcm"
			@session.remember_me = true
		end
	end

	def create
		@session = Session.new(params[:session])

		if @session.valid?
			usuario = Usuario.find_by_auth_token(cookies[:remember_me]) if @session.remember_me? && cookies[:remember_me]
			usuario ||= Usuario.login(@session.login_name, @session.password)

			cookies.delete(:remember_me) if !@session.remember_me?

			if usuario
				update_session_user(usuario)			
				cookies.permanent[:remember_me] = usuario.auth_token if @session.remember_me?	
				redirect_to session[:requested_url] || root_path
			else
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

	def reset_password
		usuario = Usuario.find_by_password_reset_token(params[:id])

		if usuario
			update_session_user(usuario)
			redirect_to edit_usuario_path(usuario)
		else
			remove_session_user
			redirect_to new_sessions_path, notice: "Código de autenticação inválido ou expirado!"
		end
	end

end
