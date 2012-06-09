# -*- encoding : utf-8 -*-
require 'spec_helper'

describe "Controle Acessos" do

	context "na página inicial" do

		it "deve criar um usuário" do
			visit sign_in_path
			click_button "Crie sua conta agora mesmo"
			current_path.should eq(sign_up_path)
			fill_in "usuario_nome"                 , with: "xpto"
			fill_in "usuario_nome_login"           , with: "xpto"
			fill_in "usuario_email"                , with: "xpto@xpto.com.br"
			fill_in "usuario_password"             , with: "xpto"
			fill_in "usuario_password_confirmation", with: "xpto"
			click_button "Criar minha conta"
			current_path.should eq(root_path)
			page.should have_content("Olá Xpto")
			last_email.to.should include("xpto@xpto.com.br")
			last_email.body.should have_link("Gerente Financeiro Pessoal", href: @link)
		end

		it "não deve criar um usuário já existente" do
			create_users

			visit sign_in_path
			click_button "Crie sua conta agora mesmo"
			current_path.should eq(sign_up_path)
			fill_in "usuario_nome"                 , with: "xpto"
			fill_in "usuario_nome_login"           , with: "xpto"
			fill_in "usuario_email"                , with: "xpto@xpto.com.br"
			fill_in "usuario_password"             , with: "xpto"
			fill_in "usuario_password_confirmation", with: "xpto"
			click_button "Criar minha conta"
			current_path.should eq(usuarios_path)
			page.should have_content("Nome de usuário já cadastrado!")
		end	

	  it "deve efetuar o login" do
	  	do_login

	    page.should have_content("Olá Xpto")
	  end

		it "não deve efeturar o login com credenciais inválidas" do
	  	create_users

	    visit sign_in_path
	    fill_in "session_login_name", with: "xpto1"
	    fill_in "session_password"  , with: "xpto"
	    click_button "Acessar" 
	    current_path.should eq(sign_in_path)
	    page.should have_content("Credenciais inválidas!")
	  end	  

		it "deve lembrar as credenciais" do
	  	do_login(true)

	    click_link "Sair"
	    page.find_field("session_login_name").value.should eq(@usuario_logado.nome_login)
	    page.find_field("session_password").value.should eq("ztySUlt3b+mKPX3fcm")

	    uncheck "session_remember_me"
	    click_button "Acessar"
	    page.should have_content("Credenciais inválidas!")
	    page.find_field("session_login_name").value.should nil
	    page.find_field("session_password").value.should nil

	    fill_in "session_login_name", with: "xpto"
	    fill_in "session_password"  , with: "xpto"
	    click_button "Acessar"
	    current_path.should eq(root_path)

	    click_link "Sair"
	    page.find_field("session_login_name").value.should nil
	    page.find_field("session_password").value.should nil
	  end

	 	it "deve solicitar a redefinição da senha" do 
			create_users

			visit sign_in_path
			click_link "Esqueceu sua senha?"
			current_path.should eq(password_reset_new_path)
			
			fill_in "email", with: "123@456.com"
			click_button "Enviar"  	
			current_path.should eq(password_reset_new_path)
			page.should have_content("E-mail não cadastrado!")
			last_email.should nil

			fill_in "email", with: @usuario_teste.email
			click_button "Enviar"  			
			current_path.should eq(sign_in_path)

			usuario_send = Usuario.find_by_email(@usuario_teste.email)
			
			page.should have_content("As instruções para troca de sua senha foram enviadas para o e-mail #{usuario_send.email}")
			last_email.to.should include(usuario_send.email)
			last_email.body.should have_link("Alterar minha senha", href: @link)

			visit "#{password_reset_edit_path}?id=#{usuario_send.password_reset_token}"
			current_path.should eq(profile_edit_path(usuario_send))				
		end

	end  

 	context "geral" do

		it "não deve acessar recursos protegidos" do
			visit root_path
			current_path.should eq(sign_in_path)

			do_login
			
	    click_link "Perfil"
	    current_path.should eq(profile_edit_path(@usuario_logado))
		end

 	end	

end
