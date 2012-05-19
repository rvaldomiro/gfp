# -*- encoding : utf-8 -*-
class PasswordsController < ApplicationController

  def forgot
  	@email = nil
  end

  def reset
  	usuario = Usuario.find_by_email(params[:email])

    if usuario      
	  	UsuarioMailer.mail_reset_senha(request, build_password_reset(usuario)).deliver
	  	redirect_to new_sessions_path, notice: "As instruções para troca de sua senha foram enviadas para o e-mail #{params[:email]}"
	  else
		  redirect_to passwords_forgot_path, notice: "e-mail não cadastrado!"  	
  	end
  end

  private

  def build_password_reset(usuario)
    password_reset = Digest::SHA1.hexdigest((usuario.id * Date.today.day).to_s + Time.now.to_s)
    usuario.password_reset = password_reset
    usuario.save
    usuario
  end

end
