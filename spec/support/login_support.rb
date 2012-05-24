module LoginSupport

	def need_login(remember_me=false)
		create_users

    visit new_sessions_path
    fill_in "session_login_name", :with => "xpto"
    fill_in "session_password"  , :with => "xpto"
    check "session_remember_me" if remember_me 
    click_button "Login"
    current_path.should eq(root_path)
	end

	def create_users
		@usuario_logado = FactoryGirl.create(:usuario)
		@usuario_teste  = FactoryGirl.create(:usuario2)				
	end

end