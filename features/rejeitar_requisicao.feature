#language: pt
Funcionalidade: Rejeitar uma requisição com estado Em Espera
Como um administrador
Eu quero rejeitar uma requisição
Para que eu possa avisar ao professor que não posso atender a requisição

  Cenário:
    Dado que eu tenho uma requisição com estado "Em Espera"
    E que eu tenho um motivo com descrição "Falta de carros"
    E que eu estou na página de detalhes da requisição
    Quando eu clico em "Rejeitar"
    E eu pressiono "Rejeitar requisição"
    Então eu devo estar na página de detalhes da requisição
    E eu devo ver "Estado: Rejeitada"

