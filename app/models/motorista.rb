require "brazilian_date"
class Motorista < ActiveRecord::Base
  
  ATIVO = "Ativo"
  INATIVO = "Inativo"
  
  has_many :viagens
  
  use_in_brazilian_format :vencimento_habilitacao  

  validates_presence_of :matricula,
                        :nome,
                        :telefone
                        
                        



  def self.ocupados_entre(data_partida, data_chegada)
    motoristas_ocupados = []

    Motorista.all.each do |motorista|
      viagens = Viagem.find_all_by_motorista_id(motorista.id)
      viagens.each do |viagem|
        if (data_partida >= viagem.data_partida and data_partida <= viagem.data_chegada) or
           (data_chegada >= viagem.data_partida and data_chegada <= viagem.data_chegada)
           
          motoristas_ocupados << [motorista.nome, motorista.id]
        end
      end
    end
    return motoristas_ocupados.uniq
  end

  def self.desocupados_entre(data_partida, data_chegada)
    motoristas_desocupados = []

    Motorista.all.each do |motorista|
      viagens = Viagem.find_all_by_motorista_id(motorista.id)
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
    return motoristas_desocupados.uniq
  end
end

