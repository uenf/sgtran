class UsuariosController < ApplicationController

  access_control do
    allow :admin, :to => [:index, :new, :show, :create, :edit, :destroy, :update]
    allow :visit, :to => [:index, :show]
  end
  # GET /usuarios
  # GET /usuarios.xml

  layout "sistema"


  def index
    @usuarios = Usuario.all
    @sub_layout = "base"

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @usuarios }
    end
  end

  # GET /usuarios/1
  # GET /usuarios/1.xml
  def show
    @usuario = Usuario.find(params[:id])
    @roles = Role.find_by_sql("SELECT name FROM roles_usuarios, roles WHERE roles_usuarios.usuario_id='"+params[:id]+"' AND roles_usuarios.role_id=roles.id")
    @sub_layout = "base"

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @usuario }
    end
  end

  # GET /usuarios/new
  # GET /usuarios/new.xml
  def new
    @usuario = Usuario.new
    @sub_layout = "base"

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @usuario }
    end
  end

  # GET /usuarios/1/edit
  def edit
    @usuario = Usuario.find(params[:id])
    @sub_layout = "base"
  end

  # POST /usuarios
  # POST /usuarios.xml
  def create
    @usuario = Usuario.new(params[:usuario])
    @role = Role.all

    respond_to do |format|
      if @usuario.save
        role = params[:role] ? params[:role] : :visit
        @usuario.has_role! role
        flash[:notice] = 'Usuário criado com sucesso!'
        format.html { redirect_to(@usuario) }
        format.xml  { render :xml => @usuario, :status => :created, :location => @usuario }
      else
        @sub_layout = "base"
        format.html { render :action => "new" }
        format.xml  { render :xml => @usuario.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /usuarios/1
  # PUT /usuarios/1.xml
  def update
    @usuario = Usuario.find(params[:id])

    respond_to do |format|
      if @usuario.update_attributes(params[:usuario])
        role = params[:role] ? params[:role] : :visit
        @usuario.has_role! role
        flash[:notice] = 'Usuario was successfully updated.'
        format.html { redirect_to(@usuario) }
        format.xml  { head :ok }
      else
        @sub_layout = "base"
        format.html { render :action => "edit" }
        format.xml  { render :xml => @usuario.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /usuarios/1
  # DELETE /usuarios/1.xml
  def destroy
    @usuario = Usuario.find(params[:id])
    @usuario.destroy
    @sub_layout = "base"

    respond_to do |format|
      format.html { redirect_to(usuarios_url) }
      format.xml  { head :ok }
    end
  end
end

