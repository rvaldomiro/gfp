# -*- encoding : utf-8 -*-
class Usuario < ActiveRecord::Base

	has_secure_password

  attr_accessible :nome, :nome_login, :email, :password_digest, :password, :password_confirmation

  validates :nome,  :nome_login, :email, presence: true
  validates :nome_login, uniqueness: { message: "Nome de usuário já cadastrado!" }
  validates :email, uniqueness: { message: "E-mail já cadastrado!" }
  	
  validates_format_of :email, with: /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i, message: "E-mail inválido!"

  before_create { generate_unique_random_token(:auth_token) }

  before_save { |u| 
    u.nome = u.nome.titleize
    u.email.downcase!
  }

	def self.login(usuario, senha)
		find(:first, conditions: ["nome_login = ? or email = ?", usuario, usuario]).try(:authenticate, senha)
	end

  def reset_password
    generate_unique_random_token(:password_reset_token)
    save
  end

  private

  def generate_unique_random_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64 + SecureRandom.urlsafe_base64
    end while Usuario.exists?(column => self[column])
  end

end
