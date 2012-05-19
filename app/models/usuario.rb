# -*- encoding : utf-8 -*-
class Usuario < ActiveRecord::Base

	has_secure_password

  attr_accessible :nome, :email, :password_digest, :password, :password_confirmation

  validates :nome,  :presence => true
  validates :email, :presence => true, :uniqueness => true
  	
  validates_format_of :email,
                      :with    => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i,
                      :message => 'E-Mail inválido!'

	def self.login(email, senha)
		find_by_email(email).try(:authenticate, senha)
	end

end
