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

#  def distancia_percorrida_entre inicio, fim
#    inicio =  inicio.to_date
#    fim =  fim.to_date

#    bdts = Bdt.find_by_sql(["SELECT * FROM (SELECT * from bdts WHERE \
#             :inicio <= data_partida AND :fim >= data_recolhimento) as t1 JOIN
#             (SELECT viagem_id from motoristas_viagens WHERE motorista_id = :id) as t2 \
#             ON t1.viagem_id = t2.viagem_id",
#             {:inicio => inicio, :fim => fim, :id => self.id}])

#    soma_km = 0
#    bdts.each do |bdt|
#      soma_km += bdt.distancia_percorrida
#    end
#    soma_km
#  end

  def distancia_percorrida_entre inicio, fim
    inicio =  inicio.to_date
    fim =  fim.to_date

    bdts = Bdt.find_by_sql(["SELECT * FROM (SELECT \
             viagem_id, odometro_recolhimento, odometro_partida from bdts WHERE \
             :inicio <= data_partida AND :fim >= data_recolhimento) as t1 JOIN
             (SELECT viagem_id from motoristas_viagens WHERE motorista_id = :id) as t2 \
             ON t1.viagem_id = t2.viagem_id",
             {:inicio => inicio, :fim => fim, :id => self.id}])

    soma_km = 0
    bdts.each do |bdt|
      soma_km += bdt.distancia_percorrida
    end
    soma_km
  end

  def nome_e_sobrenome
    conectores = ['da', 'das', 'do', 'dos', 'de']
    nome_lista = self.nome.split
    if conectores.include? nome_lista[-2].downcase
      return "#{nome_lista.first} #{nome_lista[-2]} #{nome_lista.last}"
    end
    "#{nome_lista.first} #{nome_lista.last}"
  end

  def ativo?
    self.status == "Ativo"
  end
end

