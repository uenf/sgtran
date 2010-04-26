class Motorista < ActiveRecord::Base
  has_many :viagens

  validates_presence_of :matricula,
                        :nome,
                        :telefone
                        
                        
  use_in_brazilian_format :vencimento_habilitacao


  def self.ocupados_entre(data_partida, data_chegada)
    motoristas = Motorista.all
    motoristas_ocupados = []

    motoristas.each do |motorista|
      viagens = Viagem.find_all_by_motorista_id(motorista.id)
      if viagens
        viagens.each do |viagem|
          if (data_partida >= viagem.data_partida and data_partida <= viagem.data_chegada) or
                (data_chegada >= viagem.data_partida and data_chegada <= viagem.data_chegada)
            flag=0
            motoristas_ocupados.each do |item|
              flag += 1 if item.include? motorista.id
            end
            motoristas_ocupados << [motorista.nome, motorista.id] if flag == 0
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
            flag=0
            motoristas_desocupados.each do |item|
              flag += 1 if item.include? motorista.id
            end
            motoristas_desocupados << [motorista.nome, motorista.id] if flag == 0
          end
        end
      else
        motoristas_desocupados << [motorista.nome, motorista.id]
      end
    end
    return motoristas_desocupados
  end
end

