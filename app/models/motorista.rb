require "brazilian_date"
class Motorista < ActiveRecord::Base

  ATIVO = "Ativo"
  INATIVO = "Inativo"

  has_many :viagens

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

    Motorista.all.each do |motorista|
      if motorista.ativo?
        viagens = Viagem.find_all_by_motorista_id(motorista.id)
        viagens.each do |viagem|
          if (data_partida >= viagem.data_partida and data_partida <= viagem.data_chegada) or
             (data_chegada >= viagem.data_partida and data_chegada <= viagem.data_chegada)

            motoristas_ocupados << [motorista.nome, motorista.id]
          end
        end
      end
    end
    return motoristas_ocupados.uniq
  end

  def self.desocupados_entre(data_partida, data_chegada)
    motoristas_desocupados = []

    Motorista.all.each do |motorista|
      viagens = Viagem.find_all_by_motorista_id(motorista.id)
      if motorista.ativo?
        if not viagens.empty?
          viagens.each do |viagem|
            if not (data_partida >= viagem.data_partida and data_partida <= viagem.data_chegada) and
               not (data_chegada >= viagem.data_partida and data_chegada <= viagem.data_chegada)

              motoristas_desocupados << [motorista.nome, motorista.id]
            end
          end
        else
          motoristas_desocupados << [motorista.nome, motorista.id]
        end
      end
    end
    return motoristas_desocupados.uniq
  end

  def ativo?
    true ? self.estado == "Ativo" : false
  end
end

