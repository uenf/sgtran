#language: pt
Funcionalidade: Buscar requisições por data, solicitante
  
  Como um administrador
  Eu quero buscar os dados
  Para que eu possa ter os dados desejados
  
    Cenário: Buscar uma requisição pela data
      Dado que eu tenho uma requisição com data de reserva "Daqui a 2 dias" e com solicitante com nome "Professor 1" e com matrícula "10200"
      Dado que eu tenho uma requisição com data de reserva "Daqui a 6 dias" e com solicitante com nome "Professor 2" e com matrícula "10200"
      E que eu estou na página de visualização de requisições
      Quando eu seleciono "Data" em "Buscar por:"
      E eu preencho data de "Início" com "Daqui a 1 dias"
      E eu preencho data de "Fim" com "Daqui a 4 dias"
      E eu pressiono "Buscar"
      Então eu devo ver "Professor 1"
      E eu não devo ver "Professor 2"
      
    Cenário: Buscar uma requisição pelo nome do solicitante
      Dado que eu tenho uma requisição com data de reserva "Daqui a 2 dias" e com solicitante com nome "Professor 1" e com matrícula "10200"
      Dado que eu tenho uma requisição com data de reserva "Daqui a 6 dias" e com solicitante com nome "Professor 2" e com matrícula "10200"
      E que eu estou na página de visualização de requisições
      Quando eu seleciono "Nome" em "Buscar por:"
      E eu preencho "Nome" com "Professor"
      E eu pressiono "Buscar"
      Então eu devo ver "Professor 1"
      
    Cenário: Buscar uma requisição pelo protocolor
      Dado que eu tenho uma requisição com protocolo "13"
      Dado que eu tenho uma requisição com protocolo "15"
      E que eu estou na página de visualização de requisições
      Quando eu seleciono "Protocolo" em "Buscar por:"
      E eu preencho "Protocolo" com "13"
      E eu pressiono "Buscar"
      Então eu devo ver "13"
      E eu não devo ver "15"
