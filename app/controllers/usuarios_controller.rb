# -*- encoding : utf-8 -*-
class UsuariosController < ApplicationController

  respond_to :html

  def new
    @usuario = Usuario.new
    respond_with @usuario
    # respond_to do |format|
    #   format.html # new.html.erb
    #   format.json { render json: @usuario }
    # end
  end

  def edit
    @usuario = session_user
  end

  def create
    @usuario = Usuario.new(params[:usuario])

    respond_to do |format|
      if @usuario.save
        update_session_user(@usuario)
        UsuarioMailer.mail_boas_vindas(@usuario).deliver
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
    @usuario = session_user
  
    respond_to do |format|
      if @usuario.destroy
        remove_session_user
        format.html { redirect_to new_sessions_path }
      else
        format.html { render action: "edit", notice: "Não foi possível excluir seu perfil!" }  
      end
    end
  end

  def teste
    
  end

end
