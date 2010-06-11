Factory.define :viagem do |viagem|
  viagem.motorista_id nil
  viagem.data_partida Date.today + 2.days
  viagem.data_chegada Date.today + 2.days
  viagem.estado Viagem::AGUARDANDO
end

