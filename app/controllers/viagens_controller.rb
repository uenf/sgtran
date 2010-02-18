class ViagensController < ApplicationController
  # GET /viagens
  # GET /viagens.xml

  access_control do
    allow :admin, :to => [:index, :show, :new, :edit, :create, :update, :destroy, :viagens_existentes, :filtrar]
  end

  layout "sistema"

  def index
    @viagens = Viagem.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @viagens }
    end
  end
  
  def filtrar
    filtro = params[:filtro]
    @viagens = Viagem.filtrar(filtro)
    render :action => "index"
    
  end

  # GET /viagens/1
  # GET /viagens/1.xml
  def show
    @viagem = Viagem.find(params[:id])
    @motorista = Motorista.find(@viagem.motorista_id) if not @viagem.motorista_id.nil?
    @veiculo = Veiculo.find(@viagem.veiculo_id) if not @viagem.veiculo_id.nil?

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @viagem }
    end
  end

  # GET /viagens/new
  # GET /viagens/new.xml
  def new
    @viagem = Viagem.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @viagem }
    end
  end

  # GET /viagens/1/edit
  def edit
    @viagem = Viagem.find(params[:id])
  end

  # POST /viagens
  # POST /viagens.xml
  def create
    @viagem = Viagem.new(params[:viagem])

    respond_to do |format|
      if @viagem.save
        flash[:notice] = 'Viagem was successfully created.'
        format.html { redirect_to(@viagem) }
        format.xml  { render :xml => @viagem, :status => :created, :location => @viagem }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @viagem.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /viagens/1
  # PUT /viagens/1.xml
  def update
    @viagem = Viagem.find(params[:id])

    respond_to do |format|
      if @viagem.update_attributes(params[:viagem])
        flash[:notice] = 'Viagem was successfully updated.'
        format.html { redirect_to(@viagem) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @viagem.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /viagens/1
  # DELETE /viagens/1.xml
  def destroy
    @viagem = Viagem.find(params[:id])
    @viagem.destroy

    respond_to do |format|
      format.html { redirect_to(viagens_url) }
      format.xml  { head :ok }
    end
  end

end

