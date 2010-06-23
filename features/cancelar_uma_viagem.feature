#language: pt
Funcionalidade: Cancelar uma viagem
  Como um administrador
  Eu quero cancelar uma viagem
  Para que eu possa controlar as viagens

  Cenário: Cancelar uma viagem com motivo
    Dado que eu tenho uma requisição com estado "Aceita"
    E que eu tenho uma viagem com o estado "Aguardando"
    E que a requisição esteja ligada à viagem
    E que eu tenho um motivo com descrição "Falta de carros"
    E que eu estou na página de visualização da viagem
    Quando eu clico em "Cancelar viagem"
    E eu seleciono "Falta de carros" em "Motivo do cancelamento"
    E eu pressiono "Cancelar viagem"
    Então eu devo estar na página de visualização de viagens
    E a requisição deve estar cancelada pelo sistema
    

