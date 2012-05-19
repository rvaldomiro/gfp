# -*- encoding : utf-8 -*-
class PasswordsController < ApplicationController

  def forgot
  	@email = nil
  end

  def reset
  	usuario = Usuario.find_by_email(params[:email])

    if usuario
	  	UsuarioMailer.mail_reset_senha(usuario).deliver
	  	redirect_to new_sessions_path, notice: "Instruções para troca de senha foram enviadas para o e-mail #{params[:email]}"
	  else
		  redirect_to passwords_forgot_path, notice: "E-Mail não cadastrado!"  	
  	end
  end

end