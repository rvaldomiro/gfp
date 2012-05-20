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

		respond_to do |format|
			if @usuario.save
				update_session_user(@usuario)
				UsuarioMailer.mail_boas_vindas(request, @usuario).deliver
				format.html { redirect_to root_path }
				format.json { render json: @usuario, status: :created, location: @usuario }
			else
				format.html { render action: "new" }
				format.json { render json: @usuario.errors, status: :unprocessable_entity }
			end
		end
	end

	def update
		@usuario = session_user

		respond_to do |format|
			if @usuario.update_attributes(params[:usuario])
				update_session_user(@usuario)
				format.html { redirect_to root_path, notice: 'Seu perfil foi atualizado com sucesso!' }
				format.json { head :no_content }
			else
				format.html { render action: "edit" }
				format.json { render json: @usuario.errors, status: :unprocessable_entity }
			end
		end
	end

	def destroy
		# @usuario = session_user
		@usuario = Usuario.find(params[:id])
		@usuario.destroy
		remove_session_user

		respond_to do |format|
			format.html { redirect_to new_sessions_path }
		end
	end

end
