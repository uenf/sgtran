class MotivosController < ApplicationController
  # GET /motivos
  # GET /motivos.xml
    access_control do
    allow :admin, :to => [:index, :new, :show, :create, :edit, :destroy, :update]
    allow :visit, :to => [:index, :show]
  end

  layout "sistema"

  def index
    @motivos = Motivo.all
    @sub_layout = "base"

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @motivos }
    end
  end

  # GET /motivos/1
  # GET /motivos/1.xml
  def show
    @motivo = Motivo.find(params[:id])
    @sub_layout = "base"

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @motivo }
    end
  end

  # GET /motivos/new
  # GET /motivos/new.xml
  def new
    @motivo = Motivo.new
    @sub_layout = "base"

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @motivo }
    end
  end

  # GET /motivos/1/edit
  def edit
    @motivo = Motivo.find(params[:id])
    @sub_layout = "base"
  end

  # POST /motivos
  # POST /motivos.xml
  def create
    @motivo = Motivo.new(params[:motivo])

    respond_to do |format|
      if @motivo.save
        flash[:sucesso] = 'Motivo criado com sucesso!'
        format.html { redirect_to(@motivo) }
        format.xml  { render :xml => @motivo, :status => :created, :location => @motivo }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @motivo.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /motivos/1
  # PUT /motivos/1.xml
  def update
    @motivo = Motivo.find(params[:id])

    respond_to do |format|
      if @motivo.update_attributes(params[:motivo])
        flash[:sucesso] = 'Motivo modificado com sucesso!'
        format.html { redirect_to(@motivo) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @motivo.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /motivos/1
  # DELETE /motivos/1.xml
  def destroy
    @motivo = Motivo.find(params[:id])
    @motivo.destroy
    @sub_layout = "base"

    respond_to do |format|
      format.html { redirect_to(motivos_url) }
      format.xml  { head :ok }
    end
  end
end

