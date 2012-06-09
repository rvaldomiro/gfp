# -*- encoding : utf-8 -*-
require 'spec_helper'

describe "Navegação" do

  before(:each) do 
    do_login
  end

  context "em manutenção do perfil" do

    it "deve atualizar" do
      click_link "Perfil"
      current_path.should eq(profile_edit_path(@usuario_logado))
      page.should have_link("Cancelar", href: root_path)
      fill_in "usuario_nome", with: "xpto1"
      click_button "Gravar"
      current_path.should eq(root_path) 
      Usuario.find(@usuario_logado).nome.should eq("Xpto1")             
      page.should have_content("Seu perfil foi atualizado com sucesso!")
    end

    it "não deve atualizar" do
      click_link "Perfil"
      current_path.should eq(profile_edit_path(@usuario_logado))
      page.should have_link("Cancelar", href: root_path)
      fill_in "usuario_nome", with: "xpto1"
      click_link "Cancelar"
      current_path.should eq(root_path)
      Usuario.find(@usuario_logado).nome.should eq("Xpto")  
    end

    it "deve excluir" do
      click_link "Perfil"
      click_link "Excluir Perfil"
      current_path.should eq(sign_in_path)
      page.should have_content("Seu perfil foi excluído com sucesso! Obrigado por utilizar o GFP.")
    end  

  end 

  context "geral" do

    it "deve encerrar a sessão" do
      click_link "Sair"
      current_path.should eq(sign_in_path)
    end  

  end

end
