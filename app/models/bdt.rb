class Bdt < ActiveRecord::Base

  has_one :viagem

  validates_presence_of :numero, :odometro_partida, :odometro_recolhimento

  def salvar dados_viagem
    self.viagem_id = dados_viagem[:id]
    if self.save
      viagem = Viagem.find(dados_viagem[:id])
      dados_viagem.delete(:id)
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

end

