class ObjetivosDeReservaController < ApplicationController
  access_control do
    allow :admin, :to => [:index, :new, :show, :create, :edit, :destroy, :update]
    allow :visit, :to => [:index, :show]
  end

  layout "sistema"

  def index
    @objetivos_de_reserva = ObjetivoDeReserva.all
    @sub_layout = "base"
  end

  def show
    @objetivo_de_reserva = ObjetivoDeReserva.find(params[:id])
    @sub_layout = "base"
  end

  def new
    @objetivo_de_reserva = ObjetivoDeReserva.new
    @sub_layout = "base"
  end

  def edit
    @objetivo_de_reserva = ObjetivoDeReserva.find(params[:id])
    @sub_layout = "base"
  end

  def create
    @objetivo_de_reserva = ObjetivoDeReserva.new(params[:objetivo_de_reserva])

    if @objetivo_de_reserva.save
      flash[:sucesso] = 'Objetivo de reserva criado com sucesso!'
      redirect_to(@objetivo_de_reserva)
    else
      render :action => "new"
    end
  end

  def update
    @objetivo_de_reserva = ObjetivoDeReserva.find(params[:id])

    if @objetivo_de_reserva.update_attributes(params[:objetivo_de_reserva])
      flash[:sucesso] = 'Objetivo de reserva modificado com sucesso!'
      redirect_to(@objetivo_de_reserva)
    else
      render :action => "edit"
    end
  end

  def destroy
    @objetivo_de_reserva = ObjetivoDeReserva.find(params[:id])
    @objetivo_de_reserva.destroy
    @sub_layout = "base"
    redirect_to(objetivos_de_reserva_url)
  end
end

