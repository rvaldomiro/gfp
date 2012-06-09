# -*- encoding : utf-8 -*-
require 'spec_helper'

describe "Navegacao" do

  it "alterando informações do perfil" do
  	need_login

    click_link "Perfil"
    current_path.should eq(edit_usuario_path(@usuario_logado))
    page.should have_link("Cancelar", href: root_path)
    fill_in "usuario_nome", with: "xpto1"
    click_button "Gravar"
    current_path.should eq(root_path)      
    page.should have_content("Seu perfil foi atualizado com sucesso!")
  end

  it "excluindo o perfil" do
  	need_login

    click_link "Perfil"
    click_link "Excluir Perfil"
    current_path.should eq(new_sessions_path)
    page.should have_content("Seu perfil foi excluído com sucesso! Obrigado por utilizar o GFP.")
  end  

  it "encerrando a sessão" do
  	need_login

    click_link "Sair"
    current_path.should eq(new_sessions_path)
  end  

end
