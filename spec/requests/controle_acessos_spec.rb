# -*- encoding : utf-8 -*-
require 'spec_helper'

describe "ControleAcessos" do

	it "criando um usuario" do
		visit new_sessions_path
		click_button "Crie sua conta agora mesmo"
		current_path.should eq(new_usuario_path)
		fill_in "usuario_nome"                 , :with => "xpto"
		fill_in "usuario_nome_login"           , :with => "xpto"
		fill_in "usuario_email"                , :with => "xpto@xpto.com.br"
		fill_in "usuario_password"             , :with => "xpto"
		fill_in "usuario_password_confirmation", :with => "xpto"
		click_button "Gravar"
		current_path.should eq(root_path)
		page.should have_content("Bem-vindo Xpto")
		last_email.to.should include("xpto@xpto.com.br")
	end

	it "criando um usuario que já existe" do
		create_users

		visit new_sessions_path
		click_button "Crie sua conta agora mesmo"
		current_path.should eq(new_usuario_path)
		fill_in "usuario_nome"                 , :with => "xpto"
		fill_in "usuario_nome_login"           , :with => "xpto"
		fill_in "usuario_email"                , :with => "xpto@xpto.com.br"
		fill_in "usuario_password"             , :with => "xpto"
		fill_in "usuario_password_confirmation", :with => "xpto"
		click_button "Gravar"
		current_path.should eq(usuarios_path)
		page.should have_content("Nome de usuário e/ou e-mail já cadastrados!")
	end	

  it "logando com usuario registrado" do
  	need_login

    page.should have_content("Bem-vindo Xpto")
  end

  it "logando com credenciais inválidas" do
  	create_users

    visit new_sessions_path
    fill_in "session_login_name", :with => "xpto1"
    fill_in "session_password"  , :with => "xpto"
    click_button "Login" 
    current_path.should eq(new_sessions_path)
    page.should have_content("Credenciais inválidas!")
  end

  it "solicitando alteração de senha" do 
		create_users

		visit new_sessions_path
		click_link "Esqueceu sua senha?"
		current_path.should eq(passwords_forgot_path)
		
		fill_in "email", :with => "123@456.com"
		click_button "Enviar"  	
		current_path.should eq(passwords_forgot_path)
		page.should have_content("e-mail não cadastrado!")
		last_email.should nil

		fill_in "email", :with => @usuario_teste.email
		click_button "Enviar"  	
		current_path.should eq(new_sessions_path)
		page.should have_content("As instruções para troca de sua senha foram enviadas para o e-mail #{@usuario_teste.email}")
		last_email.to.should include(@usuario_teste.email)

		@usuario_teste = Usuario.find(@usuario_teste)
		visit "#{sessions_reset_password_path}?id=#{@usuario_teste.password_reset}"
		current_path.should eq(edit_usuario_path(@usuario_teste))				
	end

	it "acessando recursos protegidos" do
		visit root_path
		current_path.should eq(new_sessions_path)

		need_login
    click_link "Perfil"
    current_path.should eq(edit_usuario_path(@usuario_logado))
	end

end