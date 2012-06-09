# -*- encoding : utf-8 -*-
module LoginSupport

	def do_login(remember=false)
		create_users

    visit sign_in_path
    fill_in "session_login_name", with: @usuario_logado.nome_login
    fill_in "session_password"  , with: @usuario_logado.password
    check "session_remember_me" if remember 
    click_button "Acessar"
    current_path.should eq(root_path)
	end

	def create_users
		@usuario_logado = FactoryGirl.create(:usuario)
		@usuario_teste  = FactoryGirl.create(:usuario2)				
	end

end
