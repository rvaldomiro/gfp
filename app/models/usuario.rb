# -*- encoding : utf-8 -*-
class Usuario < ActiveRecord::Base

	has_secure_password

  attr_accessible :nome, :nome_login, :email, :password_digest, :password, :password_confirmation

  validates :nome,  :nome_login, :email, :presence => true
  validates :email, :nome_login, :uniqueness => { :message => "Nome de usuário e/ou e-mail já cadastrados!" }
  	
  validates_format_of :email,
                      :with    => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i,
                      :message => "e-mail inválido!"

  before_create { generate_auth_token(:auth_token) }

  before_save { |o| o.nome = o.nome.capitalize }

	def self.login(usuario, senha)
		find(:first, :conditions => ["nome_login = ? or email = ?", usuario, usuario]).try(:authenticate, senha)
	end

  private

  def generate_auth_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while Usuario.exists?(column => self[column])
  end

end