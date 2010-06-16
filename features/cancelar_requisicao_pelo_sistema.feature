#language: pt
Funcionalidade: Cancelar uma requisição pelo sistema
  Como um administrador
  Eu quero cancelar uma requisição
  Para que eu possa informar ao solicitante o problema ocorrido

  Cenário:
    Dado que eu tenho uma requisição com estado "Aceita"
    E que eu tenho um motivo com descrição "Falta de verba"
    E que eu tenho uma viagem com o estado "Aguardando"
    E que a requisição esteja ligada à viagem
    E que eu estou na página de detalhes da requisição
    Quando eu clico em "Cancelar requisição"
    E eu seleciono "Falta de verba" em "Motivo"
    E eu preencho "Corpo do E-mail" com "Algumas observações"
    E eu preencho "Destinatários" com "astran@uenf.br"
    E eu pressiono "Cancelar requisição"
    Então eu devo estar na página de detalhes da requisição
    E eu devo ver "Estado: Cancelado pelo sistema"


  Cenário: Viagem com apenas uma requisição e a requisição é cancelada
    Dado que eu tenho uma requisição com estado "Aceita"
    E que eu tenho um motivo com descrição "Falta de verba"
    E que eu tenho uma viagem com o estado "Aguardando"
    E que a requisição esteja ligada à viagem
    E que eu estou na página de detalhes da requisição
    Quando eu clico em "Cancelar requisição"
    E eu seleciono "Falta de verba" em "Motivo"
    E eu preencho "Corpo do E-mail" com "Algumas observações"
    E eu preencho "Destinatários" com "astran@uenf.br"
    E eu pressiono "Cancelar requisição"
    Dado que eu estou na página de visualização da viagem
    Então eu devo ver "Estado: Cancelada"

  Cenário: Viagem com mais de uma requisição e uma requisição é cancelada
    Dado que eu tenho uma requisição com estado "Aceita"
    E que eu tenho uma viagem com o estado "Aguardando"
    E que a requisição esteja ligada à viagem
    E que eu tenho uma requisição com estado "Aceita"
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
    E a requisição não deve estar ligada a nenhuma viagem
    
    
  @2
  Cenário: Cancelar a viagem com uma requisição aceita com data anterior a hoje
    Dado que eu tenho uma requisição de "2" dias atrás e com estado "Aceita"
    E que eu tenho uma viagem com o estado "Aguardando"
    E que a requisição esteja ligada à viagem    
    E que eu tenho um motivo com descrição "Não há carro disponível"    
    E que eu estou na página de visualização da viagem
    Quando eu clico em "Cancelar viagem"
    E eu seleciono "Não há carro disponível" em "Motivo do cancelamento"
    E eu pressiono "Cancelar viagem"
    E a requisição deve estar cancelada pelo sistema
    E a viagem deve estar cancelada
    E a requisição não deve estar ligada a nenhuma viagem     

