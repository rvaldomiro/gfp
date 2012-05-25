# -*- encoding : utf-8 -*-
module LoginSupport

	def need_login(remember=false)
		create_users

    visit new_sessions_path
    fill_in "session_login_name", :with => @usuario_logado.login_name
    fill_in "session_password"  , :with => @usuario_logado.password
    check "session_remember_me" if remember 
    click_button "Login"
    current_path.should eq(root_path)
	end

	def create_users
		@usuario_logado = FactoryGirl.create(:usuario)
		@usuario_teste  = FactoryGirl.create(:usuario2)				
	end

end
