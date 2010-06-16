require "brazilian_date"
require 'brazilian-rails'

class Viagem < ActiveRecord::Base

  use_in_brazilian_format :data_partida, :data_chegada

  has_many   :requisicoes
  belongs_to :motorista
  belongs_to :veiculo

  AGUARDANDO = "Aguardando"
  ATENDIDA   = "Atendida"
  CANCELADA  = "Cancelada"

  validates_presence_of :motorista_id
  validate :validar_data

  def validar_data
    if self.data_partida and self.data_chegada
      if self.data_partida > self.data_chegada
        self.errors.add("Data de chegada anterior à data de partida. Isso")
      end
    end
  end

  def self.filtrar opcao
    case opcao.to_s
      when "Aguardando" then
        return Viagem.find_all_by_estado(Viagem::AGUARDANDO, :order => "id ASC")
      when "Cancelada" then
        return Viagem.find_all_by_estado(Viagem::CANCELADA, :order => "id ASC")
      when "Atendida" then
        return Viagem.find_all_by_estado(Viagem::ATENDIDA, :order => "id ASC")
      when "Todos" then
        return Viagem.all(:order => "id ASC")
      else
        return Viagem.all(:conditions => "estado = '" + Viagem::AGUARDANDO + "'", :order => "id ASC")
    end
  end

  def requisicoes_atendidas
    atendidas = []
    Requisicao.find_all_by_viagem_id(self.id).each do |requisicao|
      atendidas << requisicao.id
    end
    atendidas
  end

  def nomes_solicitantes
    solicitantes = []
    self.requisicoes_atendidas.each do |requisicao_id|
      solicitante_id = Requisicao.find(requisicao_id).solicitante_id
      solicitante = Solicitante.find(solicitante_id)
      solicitantes << solicitante.nome if not solicitantes.include? solicitante.nome
    end
    solicitantes
  end

  def esta_aguardando?
    if self.estado == Viagem::AGUARDANDO
      return true
    end
    return false
  end

  def cancelar_viagem motivo_id
    if self.esta_aguardando?
      requisicoes = Requisicao.find_all_by_viagem_id(self.id)
      requisicoes.each do |r|
        r.estado = Requisicao::CANCELADO_PELO_SISTEMA
        r.save_with_validation false
      end
      self.estado = Viagem::CANCELADA
      self.motivo_id = motivo_id.to_i
      self.save!
    end
  end

  def pode_ser_fechada?
    if self.estado == Viagem::AGUARDANDO
      true
    else
      false
    end
  end

  def fechar_viagem
    requisicoes_atendidas = Requisicao.find_all_by_viagem_id(self.id)
    if self.pode_ser_fechada?
      self.estado = Viagem::ATENDIDA
      if self.save_with_validation false
        requisicoes_atendidas.each do |r|
          if r.pode_ser_finalizada?
            r.estado = Requisicao::FINALIZADA
            r.save_with_validation false
          end
        end
        return true
      end
    end
    false
  end

  def self.verificar_viagem viagem_id
    viagem = Viagem.find(viagem_id)
    requisicoes_atendidas = Requisicao.find(:all, :conditions => ["viagem_id = ? 
                                            AND estado <> 'Cancelado pelo professor' AND 
                                            estado <> 'Cancelado pelo sistema'", viagem.id])
    viagem.estado = Viagem::CANCELADA and viagem.save if requisicoes_atendidas.empty?
  end

  def self.buscar_por_data_de_partida(data_de_partida)
    if Date.valid? data_de_partida
      data_de_partida = data_de_partida.gsub("/", "-").to_s
      data_de_partida = Time.parse(data_de_partida).strftime("%Y-%m-%d")
      return Viagem.find_all_by_data_partida(data_de_partida)
    else
      return Viagem.all
    end
  end

  def self.buscar_por_data_de_chegada(data_de_chegada)
    if Date.valid? data_de_chegada
      data_de_chegada = data_de_chegada.gsub("/", "-").to_s
      data_de_chegada = Time.parse(data_de_chegada).strftime("%Y-%m-%d")
      return Viagem.find_all_by_data_chegada(data_de_chegada)
    else
      return Viagem.all
    end
  end

  def self.buscar_por_motorista motorista
    motorista, viagens = "%" + motorista.to_s + "%", []
    motoristas = Motorista.find(:all, :conditions => ["nome LIKE ?", motorista])
    motoristas.each do |m|
      viagens_do_motorista = Viagem.find_all_by_motorista_id(m.id)
      viagens_do_motorista.each do |v|
        viagens << v
      end
    end
    return viagens
  end
  
  def self.buscar_por_placa placa
    placa, viagens_buscadas = "%" + placa.to_s + "%", []
    veiculos = Veiculo.find(:all, :conditions => ["placa LIKE ?", placa])
    veiculos.each do |veiculo|
      viagens = Viagem.find_all_by_veiculo_id(veiculo.id)
      viagens.each { |v| viagens_buscadas << v }
    end
    viagens_buscadas
  end

end

