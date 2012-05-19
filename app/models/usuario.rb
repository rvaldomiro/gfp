# -*- encoding : utf-8 -*-
class Usuario < ActiveRecord::Base

	has_secure_password

  attr_accessible :nome, :usuario, :email, :password_digest, :password, :password_confirmation

  validates :nome,  :usuario, :email, :presence => true
  validates :email, :usuario, :uniqueness => { :message => "Nome de usuário e/ou e-mail já cadastrados!" }
  	
  validates_format_of :email,
                      :with    => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i,
                      :message => "e-mail inválido!"

	def self.login(usuario, senha)
		find(:first, :conditions => ["usuario = ? or email = ?", usuario, usuario]).try(:authenticate, senha)
	end

end
