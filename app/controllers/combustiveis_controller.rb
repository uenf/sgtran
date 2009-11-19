class CombustiveisController < ApplicationController
  # GET /combustiveis
  # GET /combustiveis.xml
  def index
    @combustiveis = Combustivel.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @combustiveis }
    end
  end

  # GET /combustiveis/1
  # GET /combustiveis/1.xml
  def show
    @combustivel = Combustivel.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @combustivel }
    end
  end

  # GET /combustiveis/new
  # GET /combustiveis/new.xml
  def new
    @combustivel = Combustivel.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @combustivel }
    end
  end

  # GET /combustiveis/1/edit
  def edit
    @combustivel = Combustivel.find(params[:id])
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

    respond_to do |format|
      format.html { redirect_to(combustiveis_url) }
      format.xml  { head :ok }
    end
  end
end
