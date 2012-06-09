# -*- encoding : utf-8 -*-
class UsuariosController < ApplicationController

	respond_to :html

	def new
		@usuario = Usuario.new
		respond_with @usuario
	end

	def edit
		@usuario = session_user
	end

	def create
		@usuario = Usuario.new(params[:usuario])

		if @usuario.save
			update_session_user(@usuario)
			UsuarioMailer.mail_boas_vindas(request, @usuario).deliver
			redirect_to root_path
		else
			render :new
		end
	end

	def update
		@usuario = session_user

		if @usuario.update_attributes(params[:usuario])
			update_session_user(@usuario)
			redirect_to root_path, flash: { success: "Seu perfil foi atualizado com sucesso!" }
		else
			render :edit
		end
	end

	def destroy
		@usuario = session_user
		@usuario.destroy
		remove_session_user
		redirect_to sign_in_path, flash: { success: "Seu perfil foi excluído com sucesso! Obrigado por utilizar o GFP." }
	end

end
