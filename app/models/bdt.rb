class Bdt < ActiveRecord::Base

  has_one :viagem

  validates_presence_of :numero, :odometro_partida, :odometro_recolhimento

  validate :validar_odometros

  validates_time :horario_partida, :horario_recolhimento, :message => 'é inválido'
  validates_date :data_partida, :data_recolhimento, :message => 'é inválida'

  def validar_odometros
    unless self.odometro_partida.nil? and self.odometro_recolhimento.nil?
      if self.odometro_partida.to_i > self.odometro_recolhimento.to_i
        errors.add(:odometro_recolhimento, "deve ser maior do que o de partida.")
      end
    end
  end

  def salvar dados_viagem
    self.viagem_id = dados_viagem[:viagem_id]
    if self.save
      viagem = Viagem.find(dados_viagem[:viagem_id])
      dados_viagem.delete(:viagem_id)
      if viagem.update_attributes!(dados_viagem)
        viagem.fechar_viagem
        return true
      else
        return false
      end
    else
      return false
    end
  end

  def atualizar dados_bdt, dados_viagem
    if self.update_attributes(dados_bdt)
      viagem = Viagem.find(dados_viagem[:viagem_id])
      dados_viagem.delete(:viagem_id)
      if viagem.update_attributes!(dados_viagem)
        return true
      end
    end
    return false
  end

  def distancia_percorrida
    self.odometro_recolhimento - self.odometro_partida
  end

  def self.distancia_percorrida_entre inicio, fim
    inicio =  inicio.to_date
    fim =  fim.to_date
    bdts = Bdt.find(:all, :conditions => [":inicio <= data_partida AND \
                                          :fim >= data_recolhimento",
                                         {:inicio => inicio,
                                          :fim => fim}])
    soma_km = 0
    bdts.each do |bdt|
      soma_km += bdt.distancia_percorrida
    end
    soma_km
  end

end

