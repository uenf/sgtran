#language: pt
Funcionalidade: Cancelar uma requisição pelo sistema
  Como um administrador
  Eu quero cancelar uma requisição
  Para que eu possa informar ao solicitante o problema ocorrido

  Cenário:
    Dado que eu tenho uma requisição com estado "Aceita"
    E que eu tenho um motivo com descrição "Falta de verba"
    E que eu estou na página de detalhes da requisição
    Quando eu clico em "Cancelar requisição"
    E eu seleciono "Falta de verba" em "Motivo"
    E eu preencho "Observações" com "Algumas observações"    
    E eu pressiono "Cancelar requisição"
    Então eu devo estar na página de detalhes da requisição
    E eu devo ver "Estado: Cancelado pelo sistema"
    E eu devo ver "Observações do motivo: Algumas observações"

