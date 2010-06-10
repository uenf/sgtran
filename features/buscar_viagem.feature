#language: pt
Funcionalidade: Buscar uma viagem
  Como um administrador
  Eu quero buscar viagens
  Para que eu possa me organizar
  
    Cenário: Buscar uma viagem por data de partida
      Dado que eu tenho uma viagem em "Espera" com data de partida "Daqui a 2 dias"
      Dado que eu tenho uma viagem em "Espera" com data de partida "Daqui a 4 dias"
      E que eu estou na página de visualização de viagens
      Quando eu seleciono "Data de Partida" em "Buscar"
      E eu preencho a data de "Data de Partida" com "Daqui a 2 dias"
      E eu pressiono "Buscar"
      Então eu devo ver a data de "Daqui a 2 dias"
      E eu não devo ver a data de "Daqui a 4 dias"
      
    Cenário: Buscar uma viagem por data de partida informando uma data vazia
      Dado que eu tenho uma viagem em "Espera" com data de partida "Daqui a 2 dias"
      Dado que eu tenho uma viagem em "Espera" com data de partida "Daqui a 4 dias"
      E que eu estou na página de visualização de viagens
      Quando eu seleciono "Data de Partida" em "Buscar"
      E eu preencho a data de "Data de Partida" com ""
      E eu pressiono "Buscar"
      Então eu devo ver a data de "Daqui a 2 dias"
      E eu devo ver a data de "Daqui a 4 dias"
      
    Cenário: Buscar uma viagem por data de partida informando uma data inválida
      Dado que eu tenho uma viagem em "Espera" com data de partida "Daqui a 2 dias"
      Dado que eu tenho uma viagem em "Espera" com data de partida "Daqui a 4 dias"
      E que eu estou na página de visualização de viagens
      Quando eu seleciono "Data de Partida" em "Buscar"
      E eu preencho a data de "Data de Partida" com "40/05/2010"
      E eu pressiono "Buscar"
      Então eu devo ver a data de "Daqui a 2 dias"
      E eu devo ver a data de "Daqui a 4 dias"
      
    Cenário: Buscar uma viagem por data de chegada
      Dado que eu tenho uma viagem em "Espera" com data de chegada "Daqui a 2 dias"
      Dado que eu tenho uma viagem em "Espera" com data de chegada "Daqui a 4 dias"
      E que eu estou na página de visualização de viagens
      Quando eu seleciono "Data de Chegada" em "Buscar"
      E eu preencho a data de "Data de Chegada" com "Daqui a 2 dias"
      E eu pressiono "Buscar"
      Então eu devo ver a data de "Daqui a 2 dias"
      E eu não devo ver a data de "Daqui a 4 dias"
      
    Cenário: Buscar uma viagem por data de chegada informando uma data vazia
      Dado que eu tenho uma viagem em "Espera" com data de chegada "Daqui a 2 dias"
      Dado que eu tenho uma viagem em "Espera" com data de chegada "Daqui a 4 dias"
      E que eu estou na página de visualização de viagens
      Quando eu seleciono "Data de Chegada" em "Buscar"
      E eu preencho a data de "Data de Chegada" com ""
      E eu pressiono "Buscar"
      Então eu devo ver a data de "Daqui a 2 dias"
      E eu devo ver a data de "Daqui a 4 dias"

    Cenário: Buscar uma viagem por data de chegada informando uma data inválida
      Dado que eu tenho uma viagem em "Espera" com data de chegada "Daqui a 2 dias"
      Dado que eu tenho uma viagem em "Espera" com data de chegada "Daqui a 4 dias"
      E que eu estou na página de visualização de viagens
      Quando eu seleciono "Data de Chegada" em "Buscar"
      E eu preencho a data de "Data de Chegada" com "40/05/2010"
      E eu pressiono "Buscar"
      Então eu devo ver a data de "Daqui a 2 dias"
      E eu devo ver a data de "Daqui a 4 dias"           
