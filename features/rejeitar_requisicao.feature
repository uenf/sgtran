#language: pt
Funcionalidade: Rejeitar uma requisição com estado Em Espera
Como um administrador
Eu quero rejeitar uma requisição
Para que eu possa avisar ao professor que não posso atender a requisição

  Cenário:
    Dado que eu tenho uma configuração inicial
    Dado que eu sou um usuário administrador logado
    E que eu tenho uma requisição com estado "Em Espera" e id "25"
    E que eu tenho um motivo com descrição "Falta de carros"
    E que eu estou na página de detalhes da requisição
    Quando eu clico em "Rejeitar"
    E eu seleciono "Falta de carros" em "Motivo"
    E eu preencho "Corpo do E-mail" com "Meu e-mail"
    E eu preencho "Destinatários" com "eduardohertz@gmail.com"
    E eu pressiono "Rejeitar requisição"
    Então eu devo estar na página de detalhes da requisição
    E eu devo ver "Estado: Rejeitada"
    E eu devo ver "Motivo informado pelo Sistema: Falta de carros"

