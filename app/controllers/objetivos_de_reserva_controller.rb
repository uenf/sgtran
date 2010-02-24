class ObjetivosDeReservaController < ApplicationController
  # GET /objetivos_de_reserva
  # GET /objetivos_de_reserva.xml
  access_control do
    allow :admin, :to => [:index, :new, :show, :create, :edit, :destroy, :update]
    allow :visit, :to => [:index, :show]
  end

  layout "sistema"

  def index
    @objetivos_de_reserva = ObjetivoDeReserva.all
    @sub_layout = "base"

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @objetivos_de_reserva }
    end
  end

  # GET /objetivos_de_reserva/1
  # GET /objetivos_de_reserva/1.xml
  def show
    @objetivo_de_reserva = ObjetivoDeReserva.find(params[:id])
    @sub_layout = "base"

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @objetivo_de_reserva }
    end
  end

  # GET /objetivos_de_reserva/new
  # GET /objetivos_de_reserva/new.xml
  def new
    @objetivo_de_reserva = ObjetivoDeReserva.new
    @sub_layout = "base"

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @objetivo_de_reserva }
    end
  end

  # GET /objetivos_de_reserva/1/edit
  def edit
    @objetivo_de_reserva = ObjetivoDeReserva.find(params[:id])
    @sub_layout = "base"
  end

  # POST /objetivos_de_reserva
  # POST /objetivos_de_reserva.xml
  def create
    @objetivo_de_reserva = ObjetivoDeReserva.new(params[:objetivo_de_reserva])

    respond_to do |format|
      if @objetivo_de_reserva.save
        flash[:sucesso] = 'Objetivo de reserva criado com sucesso!'
        format.html { redirect_to(@objetivo_de_reserva) }
        format.xml  { render :xml => @objetivo_de_reserva, :status => :created, :location => @objetivo_de_reserva }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @objetivo_de_reserva.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /objetivos_de_reserva/1
  # PUT /objetivos_de_reserva/1.xml
  def update
    @objetivo_de_reserva = ObjetivoDeReserva.find(params[:id])

    respond_to do |format|
      if @objetivo_de_reserva.update_attributes(params[:objetivo_de_reserva])
        flash[:sucesso] = 'Objetivo de reserva modificado com sucesso!'
        format.html { redirect_to(@objetivo_de_reserva) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @objetivo_de_reserva.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /objetivos_de_reserva/1
  # DELETE /objetivos_de_reserva/1.xml
  def destroy
    @objetivo_de_reserva = ObjetivoDeReserva.find(params[:id])
    @objetivo_de_reserva.destroy
    @sub_layout = "base"

    respond_to do |format|
      format.html { redirect_to(objetivos_de_reserva_url) }
      format.xml  { head :ok }
    end
  end
end

