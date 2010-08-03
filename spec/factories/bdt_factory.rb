Factory.define :bdt do |bdt|

  bdt.data_partida Date.today - 2.days
  bdt.horario_partida Time.now - 10.hours
  bdt.odometro_partida 1000
  bdt.data_recolhimento Date.today
  bdt.horario_recolhimento Time.now
  bdt.odometro_recolhimento 1300
  bdt.objetivo "Levar alguém em algum lugar"
  bdt.numero 2
  bdt.local_origem "Algum local"
  bdt.local_destino "outro local"

end

