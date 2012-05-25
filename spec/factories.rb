# -*- encoding : utf-8 -*-
FactoryGirl.define do

	factory(:usuario) do
		nome                  "xpto"
		nome_login            "xpto"
		email                 "xpto@xpto.com"
		password              "xpto"
		password_confirmation "xpto"
	end

	factory(:usuario2, :class => :usuario) do
		nome                  "xpto2"
		nome_login            "xpto2"
		email                 "xpto2@xpto.com"
		password              "xpto2"
		password_confirmation "xpto2"
	end	

end
