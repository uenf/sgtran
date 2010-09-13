Factory.define :viagem do |viagem|
  viagem.data_partida Date.today + 2.days
  viagem.data_chegada Date.today + 2.days
  viagem.estado Viagem::AGUARDANDO
end

