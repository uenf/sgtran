class VeiculosController < ApplicationController
  # GET /veiculos
  # GET /veiculos.xml

  access_control do
    allow :admin, :to => [:index, :new, :show, :create, :edit, :destroy, :update]
    allow :visit, :to => [:index, :show]
  end


  layout "sistema"

  def index
    @veiculos = Veiculo.all
    @sub_layout = "base"

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @veiculos }
    end
  end

  # GET /veiculos/1
  # GET /veiculos/1.xml
  def show
    @veiculo = Veiculo.find(params[:id])
    @categoria = CategoriaDeVeiculo.find(@veiculo.categoria_de_veiculo_id)
    @sub_layout = "base"

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @veiculo }
    end
  end

  # GET /veiculos/new
  # GET /veiculos/new.xml
  def new
    @veiculo = Veiculo.new
    @sub_layout = "base"

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @veiculo }
    end
  end

  # GET /veiculos/1/edit
  def edit
    @veiculo = Veiculo.find(params[:id])
    @sub_layout = "base"
  end

  # POST /veiculos
  # POST /veiculos.xml
  def create
    @veiculo = Veiculo.new(params[:veiculo])

    respond_to do |format|
      if @veiculo.save
        flash[:sucesso] = 'Veículo cadastrado com sucesso!'
        format.html { redirect_to(@veiculo) }
        format.xml  { render :xml => @veiculo, :status => :created, :location => @veiculo }
      else
        @sub_layout = "base"
        format.html { render :action => "new" }
        format.xml  { render :xml => @veiculo.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /veiculos/1
  # PUT /veiculos/1.xml
  def update
    @veiculo = Veiculo.find(params[:id])

    respond_to do |format|
      if @veiculo.update_attributes(params[:veiculo])
        flash[:sucesso] = 'Veículo modificado com sucesso!.'
        format.html { redirect_to(@veiculo) }
        format.xml  { head :ok }
      else
        @sub_layout = "base"
        format.html { render :action => "edit" }
        format.xml  { render :xml => @veiculo.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /veiculos/1
  # DELETE /veiculos/1.xml
  def destroy
    @veiculo = Veiculo.find(params[:id])
    @veiculo.destroy
    @sub_layout = "base"

    respond_to do |format|
      format.html { redirect_to(veiculos_url) }
      format.xml  { head :ok }
    end
  end
end

