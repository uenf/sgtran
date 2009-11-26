class CategoriaDeVeiculosController < ApplicationController
  # GET /categoria_de_veiculos
  # GET /categoria_de_veiculos.xml
  access_control do
    allow :admin, :to => [:index, :new, :show, :create, :edit, :destroy, :update]
    allow :visit, :to => [:index, :show]
  end

  layout "sistema"


  def index
    @categoria_de_veiculos = CategoriaDeVeiculo.all
    @sub_layout = "base"

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @categoria_de_veiculos }
    end
  end

  # GET /categoria_de_veiculos/1
  # GET /categoria_de_veiculos/1.xml
  def show
    @categoria_de_veiculo = CategoriaDeVeiculo.find(params[:id])
    @sub_layout = "base"

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @categoria_de_veiculo }
    end
  end

  # GET /categoria_de_veiculos/new
  # GET /categoria_de_veiculos/new.xml
  def new
    @categoria_de_veiculo = CategoriaDeVeiculo.new
    @sub_layout = "base"

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @categoria_de_veiculo }
    end
  end

  # GET /categoria_de_veiculos/1/edit
  def edit
    @categoria_de_veiculo = CategoriaDeVeiculo.find(params[:id])
    @sub_layout = "base"
  end

  # POST /categoria_de_veiculos
  # POST /categoria_de_veiculos.xml
  def create
    @categoria_de_veiculo = CategoriaDeVeiculo.new(params[:categoria_de_veiculo])

    respond_to do |format|
      if @categoria_de_veiculo.save
        flash[:sucesso] = 'Categoria de veículo criada com sucesso!'
        format.html { redirect_to(@categoria_de_veiculo) }
        format.xml  { render :xml => @categoria_de_veiculo, :status => :created, :location => @categoria_de_veiculo }
      else
        @sub_layout = "base"
        format.html { render :action => "new" }
        format.xml  { render :xml => @categoria_de_veiculo.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /categoria_de_veiculos/1
  # PUT /categoria_de_veiculos/1.xml
  def update
    @categoria_de_veiculo = CategoriaDeVeiculo.find(params[:id])

    respond_to do |format|
      if @categoria_de_veiculo.update_attributes(params[:categoria_de_veiculo])
        flash[:sucesso] = 'Categoria de veículo modificada com sucesso!'
        format.html { redirect_to(@categoria_de_veiculo) }
        format.xml  { head :ok }
      else
        @sub_layout = "base"
        format.html { render :action => "edit" }
        format.xml  { render :xml => @categoria_de_veiculo.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /categoria_de_veiculos/1
  # DELETE /categoria_de_veiculos/1.xml
  def destroy
    @categoria_de_veiculo = CategoriaDeVeiculo.find(params[:id])
    @categoria_de_veiculo.destroy
    @sub_layout = "base"

    respond_to do |format|
      format.html { redirect_to(categoria_de_veiculos_url) }
      format.xml  { head :ok }
    end
  end
end

