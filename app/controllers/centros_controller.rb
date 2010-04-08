class CentrosController < ApplicationController
  # GET /centros
  # GET /centros.xml
  access_control do
    allow :admin, :to => [:index, :new, :show, :create, :edit, :destroy, :update]
    allow :visit, :to => [:index, :show]
  end

  layout "sistema"

  def index
    @centros = Centro.all
    @sub_layout = "base"

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @centros }
    end
  end

  # GET /centros/1
  # GET /centros/1.xml
  def show
    @centro = Centro.find(params[:id])
    @sub_layout = "base"

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @centro }
    end
  end

  # GET /centros/new
  # GET /centros/new.xml
  def new
    @centro = Centro.new
    @sub_layout = "base"

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @centro }
    end
  end

  # GET /centros/1/edit
  def edit
    @centro = Centro.find(params[:id])
    @sub_layout = "base"
  end

  # POST /centros
  # POST /centros.xml
  def create
    @centro = Centro.new(params[:centro])

    respond_to do |format|
      if @centro.save
        flash[:sucesso] = 'Centro criado com sucesso!'
        format.html { redirect_to(@centro) }
        format.xml  { render :xml => @centro, :status => :created, :location => @centro }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @centro.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /centros/1
  # PUT /centros/1.xml
  def update
    @centro = Centro.find(params[:id])

    respond_to do |format|
      if @centro.update_attributes(params[:centro])
        flash[:sucesso] = 'Centro modificado com sucesso!'
        format.html { redirect_to(@centro) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @centro.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /centros/1
  # DELETE /centros/1.xml
  def destroy
    @centro = Centro.find(params[:id])
    @centro.destroy
    @sub_layout = "base"

    respond_to do |format|
      format.html { redirect_to(centros_url) }
      format.xml  { head :ok }
    end
  end
end

