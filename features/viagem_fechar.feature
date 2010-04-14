#language: pt
Funcionalidade: Fechar uma viagem
  Como um administrador
  Eu quero fechar a viagem
  Para que eu possa gerar o BDT
  
  Cenário: Fechar uma viagem com estado Aguardando
    Dado que eu tenho uma requisição com estado "Aceita"
    E que eu tenho uma viagem com o estado "Aguardando"
    E que a requisição esteja ligada à viagem
    E que eu estou na página de visualização da viagem
    Quando eu clico em "Fechar viagem"
    E eu pressiono "Fechar viagem"
    Então eu devo estar na página de visualização da viagem
    E eu devo ver "Estado: Atendida"


