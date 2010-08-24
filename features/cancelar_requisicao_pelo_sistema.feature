#language: pt
Funcionalidade: Cancelar uma requisição pelo sistema
  Como um administrador
  Eu quero cancelar uma requisição
  Para que eu possa informar ao solicitante o problema ocorrido

  Cenário: Excluir a viagem se apenas a requisição cancelada é atendida pela viagem
    Dado que eu tenho uma requisição com estado "Aceita" e id "25"
    E que eu tenho um motivo com descrição "Falta de verba"
    E que eu tenho uma viagem com o estado "Aguardando"
    E que a requisição esteja ligada à viagem
    E que eu estou na página de detalhes da requisição
    Quando eu clico em "Cancelar requisição"
    E eu seleciono "Falta de verba" em "Motivo"
    E eu preencho "Corpo do E-mail" com "Algumas observações"
    E eu preencho "Destinatários" com "astran@uenf.br"
    E eu pressiono "Cancelar requisição"
    Então a requisição deve estar cancelada pelo sistema
    E a requisição não deve estar ligada a uma viagem
    E eu devo ter 0 viagens

  @now
  Cenário: Viagem com mais de uma requisição e uma requisição é cancelada
    Dado que eu tenho uma requisição com estado "Aceita" e id "25"
    E que eu tenho uma viagem com o estado "Aguardando"
    E que a requisição esteja ligada à viagem
    E que eu tenho uma requisição com estado "Aceita" e id "27"
    E que a requisição esteja ligada à viagem
    E que eu tenho um motivo com descrição "Falta de verba"
    E que eu estou na página de detalhes da requisição
    Quando eu clico em "Cancelar requisição"
    E eu seleciono "Falta de verba" em "Motivo"
    E eu preencho "Corpo do E-mail" com "Algumas observações"
    E eu preencho "Destinatários" com "astran@uenf.br"
    E eu pressiono "Cancelar requisição"
    Dado que eu estou na página de visualização da viagem
    Então eu devo ver "Estado: Aguardando"
    E a requisição com id "27" não deve estar ligada a uma viagem
    E a requisição com id "25" deve estar ligada a uma viagem

  Cenário: Cancelar uma requisição aceita pelo sistema com data anterior a hoje
    Dado que eu tenho uma requisição de "2" dias atrás e com estado "Aceita"
    E que eu tenho uma viagem com o estado "Aguardando"
    E que a requisição esteja ligada à viagem
    E que eu tenho um motivo com descrição "Falta de verba"
    E que eu estou na página de detalhes da requisição
    Quando eu clico em "Cancelar requisição"
    E eu seleciono "Falta de verba" em "Motivo"
    E eu preencho "Corpo do E-mail" com "Algumas observações"
    E eu preencho "Destinatários" com "astran@uenf.br"
    E eu pressiono "Cancelar requisição"
    E a requisição deve estar cancelada pelo sistema
    E a requisição não deve estar ligada a uma viagem

