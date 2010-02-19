class MotoristasController < ApplicationController

  access_control do
    allow :admin, :to => [:index, :new, :show, :create, :edit, :destroy, :update]
    allow :visit, :to => [:index, :show]
  end

  layout "sistema"
  # GET /motoristas
  # GET /motoristas.xml
  def index
    @motoristas = Motorista.all
    @sub_layout = "base"

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @motoristas }
    end
  end

  # GET /motoristas/1
  # GET /motoristas/1.xml
  def show
    @motorista = Motorista.find(params[:id])
    @sub_layout = "base"

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @motorista }
    end
  end

  # GET /motoristas/new
  # GET /motoristas/new.xml
  def new
    @motorista = Motorista.new
    @sub_layout = "base"

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @motorista }
    end
  end

  # GET /motoristas/1/edit
  def edit
    @motorista = Motorista.find(params[:id])
    @sub_layout = "base"
  end

  # POST /motoristas
  # POST /motoristas.xml
  def create
    @motorista = Motorista.new(params[:motorista])

    respond_to do |format|
      if @motorista.save
        flash[:sucesso] = 'Motorista criado com sucesso!'
        format.html { redirect_to(@motorista) }
        format.xml  { render :xml => @motorista, :status => :created, :location => @motorista }
      else
        @sub_layout = "base"
        format.html { render :action => "new" }
        format.xml  { render :xml => @motorista.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /motoristas/1
  # PUT /motoristas/1.xml
  def update
    @motorista = Motorista.find(params[:id])

    respond_to do |format|
      if @motorista.update_attributes(params[:motorista])
        flash[:sucesso] = 'Motorista modificado com sucesso!'
        format.html { redirect_to(@motorista) }
        format.xml  { head :ok }
      else
        @sub_layout = "base"
        format.html { render :action => "edit" }
        format.xml  { render :xml => @motorista.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /motoristas/1
  # DELETE /motoristas/1.xml
  def destroy
    @motorista = Motorista.find(params[:id])
    @motorista.destroy
    @sub_layout = "base"

    respond_to do |format|
      format.html { redirect_to(motoristas_url) }
      format.xml  { head :ok }
    end
  end
end

