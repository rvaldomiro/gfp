# -*- encoding : utf-8 -*-
class Session
	include ActiveModel::Validations
	include ActiveModel::Conversion
	extend ActiveModel::Naming

	attr_accessor :login_name, :password

	validates :login_name, :password, presence: true

	def initialize(attributes = {})
		attributes.each do |name, value|
			send("#{name}=".to_sym, value)
		end
	end

	def persisted?
		false
	end

end
