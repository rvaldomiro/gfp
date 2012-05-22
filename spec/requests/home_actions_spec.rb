# -*- encoding : utf-8 -*-
require 'spec_helper'

describe "HomeActions" do

  it "alterando informações do perfil" do
  	need_login

    click_link "Perfil"
    current_path.should eq(edit_usuario_path(@usuario_logado))
    fill_in "usuario_nome", :with => "xpto1"
    click_button "Gravar"
    current_path.should eq(root_path)      
    page.should have_content("Seu perfil foi atualizado com sucesso!")
  end

  it "excluindo o perfil" do
  	need_login

    click_link "Perfil"
    click_link "Excluir Perfil"
    current_path.should eq(new_sessions_path)
  end  

  it "encerrando a sessão" do
  	need_login

    click_link "Sair"
    current_path.should eq(new_sessions_path)
  end  

end