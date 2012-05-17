# -*- encoding : utf-8 -*-
class Usuario < ActiveRecord::Base

	has_secure_password

  	attr_accessible :nome, :email, :password_digest, :password, :password_confirmation

  	def self.login(email, senha)
  		find_by_email(email).try(:authenticate, senha)
  	end

end
