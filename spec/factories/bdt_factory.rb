Factory.define :bdt do |bdt|

  bdt.recolhimento Date.today
  bdt.partida Date.today - 2.days
  bdt.odometro_recolhimento 1000
  bdt.odometro_partida 1300
  bdt.objetivo "Levar alguém em algum lugar"
  bdt.numero 2
  bdt.local_origem "Algum local"
  bdt.local_destino "outro local"

end

