module ViagensHelper

  def viagem_pode_ser_cancelada(estado)
    [Viagem::AGUARDANDO].include? estado
  end
end
