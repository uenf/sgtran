class UsuariosController < ApplicationController
  access_control do
    allow :admin, :to => [:index, :new, :show, :create, :edit, :destroy, :update]
    allow :visit, :to => [:index, :show]
  end

  layout "sistema"

  def index
    @usuarios = Usuario.all
    @sub_layout = "base"
  end

  def show
    @usuario = Usuario.find(params[:id])
    @roles = Role.find_by_sql("SELECT name FROM roles_usuarios, roles WHERE roles_usuarios.usuario_id='"+params[:id]+"' AND roles_usuarios.role_id=roles.id")
    @sub_layout = "base"
  end

  def new
    @usuario = Usuario.new
    @sub_layout = "base"
  end

  def edit
    @usuario = Usuario.find(params[:id])
    @sub_layout = "base"
  end

  def create
    @usuario = Usuario.new(params[:usuario])
    @role = Role.all

    if @usuario.save
      role = params[:role] ? params[:role] : :visit
      @usuario.has_role! role
      flash[:notice] = 'Usuário criado com sucesso!'
      redirect_to(@usuario)
    else
      @sub_layout = "base"
      render :action => "new"
    end
  end

  def update
    @usuario = Usuario.find(params[:id])

    if @usuario.update_attributes(params[:usuario])
      role = params[:role] ? params[:role] : :visit
      @usuario.has_role! role
      flash[:notice] = 'Usuario was successfully updated.'
      redirect_to(@usuario)
    else
      @sub_layout = "base"
      render :action => "edit"
    end
  end

  def destroy
    @usuario = Usuario.find(params[:id])
    @usuario.destroy
    @sub_layout = "base"
    redirect_to(usuarios_url)
  end
end

