class Bdt < ActiveRecord::Base

  has_one :viagem

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

end

