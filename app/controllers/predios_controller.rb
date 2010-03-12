class PrediosController < ApplicationController
  # GET /predios
  # GET /predios.xml
  access_control do
    allow :admin, :to => [:index, :new, :show, :create, :edit, :destroy, :update]
    allow :visit, :to => [:index, :show]
  end

  layout "sistema"

  def index
    @predios = Predio.all
    @sub_layout = "base"

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @predios }
    end
  end

  # GET /predios/1
  # GET /predios/1.xml
  def show
    @predio = Predio.find(params[:id])
    @sub_layout = "base"

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @predio }
    end
  end

  # GET /predios/new
  # GET /predios/new.xml
  def new
    @predio = Predio.new
    @sub_layout = "base"

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @predio }
    end
  end

  # GET /predios/1/edit
  def edit
    @predio = Predio.find(params[:id])
    @sub_layout = "base"
  end

  # POST /predios
  # POST /predios.xml
  def create
    @predio = Predio.new(params[:predio])

    respond_to do |format|
      if @predio.save
        flash[:sucesso] = 'Prédio criado com sucesso!'
        format.html { redirect_to(@predio) }
        format.xml  { render :xml => @predio, :status => :created, :location => @predio }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @predio.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /predios/1
  # PUT /predios/1.xml
  def update
    @predio = Predio.find(params[:id])

    respond_to do |format|
      if @predio.update_attributes(params[:predio])
        flash[:sucesso] = 'Prédio modificado com sucesso!'
        format.html { redirect_to(@predio) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @predio.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /predios/1
  # DELETE /predios/1.xml
  def destroy
    @predio = Predio.find(params[:id])
    @predio.destroy
    @sub_layout = "base"

    respond_to do |format|
      format.html { redirect_to(predios_url) }
      format.xml  { head :ok }
    end
  end
end

