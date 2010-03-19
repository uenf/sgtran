class Motorista < ActiveRecord::Base
  has_many :viagens

  validates_presence_of :matricula,
                        :nome_do_motorista,
                        :telefone_do_motorista

# Comentado por não ter a mínima ideia de onde veio isso!!!
################################################################################
#  def self.verificarExistencia dados
#    find_by_matricula(dados[:matricula])
#  end
################################################################################

  def self.ocupados_entre(data_partida, data_chegada)
    motoristas = Motorista.all
    motoristas_ocupados = []

    motoristas.each do |motorista|
      viagens = Viagem.find_all_by_motorista_id(motorista.id)
      if not viagens.empty?
        viagens.each do |viagem|
          if (data_partida >= viagem.data_partida and data_partida <= viagem.data_chegada) or
                (data_chegada >= viagem.data_partida and data_chegada <= viagem.data_chegada)
            motoristas_ocupados << [motorista.nome_do_motorista, motorista.id]
          end
        end
      end
    end
    return motoristas_ocupados
  end

  def self.desocupados_entre(data_partida, data_chegada)
    motoristas = Motorista.all
    motoristas_desocupados = []

    motoristas.each do |motorista|
      viagens = Viagem.find_all_by_motorista_id(motorista.id)
      if not viagens.empty?
        viagens.each do |viagem|
          if not (data_partida >= viagem.data_partida and data_partida <= viagem.data_chegada) and
                not (data_chegada >= viagem.data_partida and data_chegada <= viagem.data_chegada)
            motoristas_desocupados << [motorista.nome_do_motorista, motorista.id]
          end
        end
      else
        motoristas_desocupados << [motorista.nome_do_motorista, motorista.id]
      end
    end
    return motoristas_desocupados
  end
end

