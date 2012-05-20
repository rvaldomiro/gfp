# -*- encoding : utf-8 -*-
class Usuario < ActiveRecord::Base

	has_secure_password

  attr_accessible :nome, :nome_login, :email, :password_digest, :password, :password_confirmation

  validates :nome,  :nome_login, :email, :presence => true
  validates :email, :nome_login, :uniqueness => { :message => "Nome de usuário e/ou e-mail já cadastrados!" }
  	
  validates_format_of :email,
                      :with    => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i,
                      :message => "e-mail inválido!"

	def self.login(nome_login, senha)
		find(:first, :conditions => ["nome_login = ? or email = ?", nome_login, nome_login]).try(:authenticate, senha)
	end

end
