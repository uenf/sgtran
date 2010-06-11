class UsuarioSessionsController < ApplicationController
  access_control do
    allow anonymous, :to => [:new, :create]
    allow :admin, :to => [:new, :destroy]
    allow :visit, :to => [:new, :destroy]
  end

  def new
    if current_user
      redirect_to(requisicoes_path)
    else
      @usuario_session = UsuarioSession.new
    end
  end

  def create
    @usuario_session = UsuarioSession.new(params[:usuario_session])

    if @usuario_session.save
      redirect_to(requisicoes_path)
    else
      render :action => "new"
    end
  end

  def destroy
    @usuario_session = UsuarioSession.find(params[:id])
    @usuario_session.destroy
    redirect_to(admin_path)
  end
end

