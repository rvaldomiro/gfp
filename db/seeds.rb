# -*- encoding : utf-8 -*-
require 'csv'

Usuario.delete_all

CSV.parse(File.read("db/usuarios.csv"), headers: true).each do |row|
	next if row[3] == "null"

	puts "usuário: #{row[3]}"
	usuario = Usuario.create! nome: row[5], email: row[3], nome_login: row[4], password: "gfp", password_confirmation: "gfp" 	
end
