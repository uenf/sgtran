class Centro < ActiveRecord::Base
  ATIVO = "Ativo"
  INATIVO = "Inativo"
  has_many :solicitantes

  validates_presence_of :nome

  def distancia_percorrida_entre inicio, fim
    inicio =  inicio.to_date
    fim =  fim.to_date

    bdts = Bdt.find_by_sql(["SELECT * FROM
            (SELECT viagem_id, odometro_recolhimento, odometro_partida FROM bdts
            WHERE :inicio <= data_partida AND :fim >= data_recolhimento) AS t4
            JOIN (SELECT viagem_id FROM (SELECT viagem_id, solicitante_id FROM
            requisicoes WHERE estado = 'Finalizada') AS t1 JOIN (SELECT id FROM
            solicitantes WHERE centro_id = :id) AS t2
            ON t1.solicitante_id = t2.id) AS t3 ON t4.viagem_id = t3.viagem_id",
             {:inicio => inicio, :fim => fim, :id => self.id}])

    soma_km = 0
    bdts.each do |bdt|
      soma_km += bdt.distancia_percorrida
    end
    soma_km
  end
end

