# -*- encoding : utf-8 -*-
class PasswordResetController < ApplicationController

  def create
  	usuario = Usuario.find_by_email(params[:email])

    if usuario     
    	usuario.reset_password
	  	UsuarioMailer.mail_reset_senha(request, usuario).deliver
	  	redirect_to new_sessions_path, flash: { notice: "As instruções para troca de sua senha foram enviadas para o e-mail #{params[:email]}" }
	  else
		  redirect_to password_reset_new_path, flash: { error: "E-mail não cadastrado!" }
  	end  	
  end

	def edit
		usuario = Usuario.find_by_password_reset_token(params[:id])

		if usuario
			update_session_user(usuario)
			redirect_to edit_usuario_path(usuario)
		else
			remove_session_user
			redirect_to new_sessions_path, flash: { error: "Código de autenticação inválido ou expirado!" }
		end
	end  

end
