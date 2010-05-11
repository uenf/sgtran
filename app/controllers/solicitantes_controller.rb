class SolicitantesController < ApplicationController
  # GET /solicitantes
  # GET /solicitantes.xml

  access_control do
    allow :admin
    allow :visit, :to => [:index, :show]
  end

  layout "sistema"


  def index
    @solicitantes = Solicitante.all(:order => "nome ASC")
    @sub_layout = "base"

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @solicitantes }
    end
  end

  # GET /solicitantes/1
  # GET /solicitantes/1.xml
  def show
    @solicitante = Solicitante.find(params[:id])
    @sub_layout = "base"

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @solicitante }
    end
  end

  # GET /solicitantes/new
  # GET /solicitantes/new.xml
  def new
    @solicitante = Solicitante.new
    @sub_layout = "base"

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @solicitante }
    end
  end

  # GET /solicitantes/1/edit
  def edit
    @solicitante = Solicitante.find(params[:id])
    @sub_layout = "base"
  end

  # POST /solicitantes
  # POST /solicitantes.xml
  def create
    @solicitante = Solicitante.new(params[:solicitante])

    respond_to do |format|
      if @solicitante.save
        flash[:sucesso] = 'Solicitante criado com sucesso!'
        format.html { redirect_to(@solicitante) }
        format.xml  { render :xml => @solicitante, :status => :created, :location => @solicitante }
      else
        @sub_layout = "base"
        format.html { render :action => "new" }
        format.xml  { render :xml => @solicitante.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /solicitantes/1
  # PUT /solicitantes/1.xml
  def update
    @solicitante = Solicitante.find(params[:id])

    respond_to do |format|
      if @solicitante.update_attributes(params[:solicitante])
        flash[:sucesso] = 'Solicitante modificado com sucesso!'
        format.html { redirect_to(@solicitante) }
        format.xml  { head :ok }
      else
        @sub_layout = "base"
        format.html { render :action => "edit" }
        format.xml  { render :xml => @solicitante.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /solicitantes/1
  # DELETE /solicitantes/1.xml
  def destroy
    @solicitante = Solicitante.find(params[:id])
    @solicitante.destroy
    @sub_layout = "base"

    respond_to do |format|
      format.html { redirect_to(solicitantes_url) }
      format.xml  { head :ok }
    end
  end
end

