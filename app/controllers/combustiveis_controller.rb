class CombustiveisController < ApplicationController
  # GET /combustiveis
  # GET /combustiveis.xml

  access_control do
    allow :admin, :to => [:index, :new, :show, :create, :edit, :destroy, :update]
    allow :visit, :to => [:index, :show]
  end

  layout "sistema"

  def index
    @combustiveis = Combustivel.all
    @sub_layout = "base"

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @combustiveis }
    end
  end

  # GET /combustiveis/1
  # GET /combustiveis/1.xml
  def show
    @combustivel = Combustivel.find(params[:id])
    @sub_layout = "base"

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @combustivel }
    end
  end

  # GET /combustiveis/new
  # GET /combustiveis/new.xml
  def new
    @combustivel = Combustivel.new
    @sub_layout = "base"

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @combustivel }
    end
  end

  # GET /combustiveis/1/edit
  def edit
    @combustivel = Combustivel.find(params[:id])
    @sub_layout = "base"
  end

  # POST /combustiveis
  # POST /combustiveis.xml
  def create
    @combustivel = Combustivel.new(params[:combustivel])

    respond_to do |format|
      if @combustivel.save
        flash[:notice] = 'Combustivel was successfully created.'
        format.html { redirect_to(@combustivel) }
        format.xml  { render :xml => @combustivel, :status => :created, :location => @combustivel }
      else
        @sub_layout = "base"
        format.html { render :action => "new" }
        format.xml  { render :xml => @combustivel.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /combustiveis/1
  # PUT /combustiveis/1.xml
  def update
    @combustivel = Combustivel.find(params[:id])

    respond_to do |format|
      if @combustivel.update_attributes(params[:combustivel])
        flash[:notice] = 'Combustivel was successfully updated.'
        format.html { redirect_to(@combustivel) }
        format.xml  { head :ok }
      else
        @sub_layout = "base"
        format.html { render :action => "edit" }
        format.xml  { render :xml => @combustivel.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /combustiveis/1
  # DELETE /combustiveis/1.xml
  def destroy
    @combustivel = Combustivel.find(params[:id])
    @combustivel.destroy
    @sub_layout = "base"

    respond_to do |format|
      format.html { redirect_to(combustiveis_url) }
      format.xml  { head :ok }
    end
  end
end

