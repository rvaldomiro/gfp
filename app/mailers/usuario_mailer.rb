class UsuarioMailer < ActionMailer::Base
  
  default :from => "contato.gfp@gmail.com"

  def mail_boas_vindas(user)
    @user = user
    @site = "http://gfp.herokuapp.com"

    mail(:to => user.email, :subject => "Seja bem-vindo ao gfp") do |format|
   		format.html { render "mail_boas_vindas" }
    end
  end

  def mail_reset_senha(user)
    @user = user
    @site = "http://gfp.herokuapp.com"

    mail(:to => user.email, :subject => "Resetando senha do gfp") do |format|
   		format.html { render "mail_reset_senha" }
    end
  end

end
