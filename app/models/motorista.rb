require "brazilian_date"
class Motorista < ActiveRecord::Base

  ATIVO = "Ativo"
  INATIVO = "Inativo"

  has_and_belongs_to_many :viagens

  use_in_brazilian_format :vencimento_habilitacao

  validates_presence_of :matricula,
                        :nome,
                        :telefone

  def self.vence_cnh_em(dias)
    lista = []
    Motorista.all.each do |motorista|
      if (not motorista.vencimento_habilitacao.nil?) and
        (motorista.vencimento_habilitacao <= (Date.today + 30.days))
        lista << motorista.id
      end
    end
    lista
  end

  def avisar_vencimento_cnh
    self.avisado = true
    self.save
  end

  def self.para_aviso_cnh
    motoristas = Motorista.vence_cnh_em(30.days)
    lista_motoristas = []
    if not motoristas.empty?
      motoristas.each do |id_motorista|
        motorista = Motorista.find(id_motorista)
        lista_motoristas << motorista.id if motorista.avisado == false
      end
    end
    lista_motoristas
  end

  def self.ocupados_entre(data_partida, data_chegada)
    motoristas_ocupados = []
    viagens = Viagem.find(:all,
              :conditions => ["estado = ? AND  \
              ((? BETWEEN data_partida AND data_chegada) OR \
              (? BETWEEN data_partida AND data_chegada))",
              'Aguardando',
              data_partida,
              data_chegada])

    Motorista.find_all_by_status("Ativo").each do |motorista|
      viagens.each do |viagem|
        if viagem.motoristas.include? motorista
          motoristas_ocupados << [motorista.nome, motorista.id]
        end
      end
    end
    return motoristas_ocupados.uniq
  end

  def self.desocupados_entre(data_partida, data_chegada)
    motoristas_desocupados = []
    motoristas_ocupados = Motorista.ocupados_entre(data_partida, data_chegada)

    Motorista.all.each do |motorista|
      if motorista.ativo?
        if not motoristas_ocupados.include?([motorista.nome, motorista.id])
          motoristas_desocupados << [motorista.nome, motorista.id]
        end
      end
    end
    return motoristas_desocupados
  end

  def distancia_percorrida_entre inicio, fim
    inicio =  inicio.to_date
    fim =  fim.to_date
    viagens_atendidas = Viagem.find_all_by_estado(Viagem::ATENDIDA)
    viagens_do_motorista = []

    viagens_atendidas.each do |viagem|
      viagens_do_motorista << viagem if viagem.motoristas.include?(self)
    end

    soma_km = 0
    viagens_do_motorista.each do |viagem|
      bdt = Bdt.find_by_viagem_id(viagem.id)
      if inicio <= bdt.data_partida and fim >= bdt.data_recolhimento:
        soma_km += bdt.distancia_percorrida
      end
    end
    soma_km
  end

  def ativo?
    self.status == "Ativo"
  end
end

