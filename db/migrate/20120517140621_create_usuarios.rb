# -*- encoding : utf-8 -*-
class CreateUsuarios < ActiveRecord::Migration
		
		def change
			create_table :usuarios do |t|
				t.string   :nome
				t.string   :nome_login
				t.string   :email
				t.string   :password_digest
				t.string   :password_reset
				t.datetime :ultimo_acesso

				t.timestamps
			end
		end

end
