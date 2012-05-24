# -*- encoding : utf-8 -*-
class UsuarioMailer < ActionMailer::Base
  
  default :from => "contato.gfp@gmail.com"

  def mail_boas_vindas(request, user)
    @site = request.host_with_port
    @user = user
    @link = "http://#{@site}"

    mail(:to => user.email, :subject => "Seja bem-vindo ao GFP") do |format|
   		format.html { render "mail_boas_vindas" }
    end
  end

  def mail_reset_senha(request, user)
    @site = request.host_with_port
    @user = user
    @link = "http://#{@site}/sessions/reset_password?id=#{@user.password_reset_token}"

    mail(:to => user.email, :subject => "Solicitação de alteração de senha") do |format|
   		format.html { render "mail_reset_senha" }
    end
  end

end
