#language: pt
Funcionalidade: enviar e-mails pelo e-mail definido na configuração
  Como um administrador
  Eu quero enviar e-mails pelo e-mail que eu defini
  Para que eu possa entrar em contato com o usuário

  Cenário: Enviar uma requisição sem os zeros à esquerda
    Dado que eu tenho uma configuração inicial
    E que a instituição tem o e-mail "teste@email.com"
    E que eu não estou logado
    E que eu tenha a categoria de veículo "Automóvel até 4 passageiros"
    E que eu tenha um objetivo de reserva "Aula de Campo"
    E que eu tenha um solicitante com e-mail "ronaldo@corinthians.com", matrícula "00210" e centro "P5"
    E que eu estou na página de requisição
    Quando eu preencho "Matrícula" com "210"
    E eu preencho "E-mail" com "ronaldo@corinthians.com"
    E eu preencho "Celular" com "9999-9999"
    E eu preencho "Data" com uma data de dois dias seguintes a partir de hoje
    E eu seleciono "Automóvel até 4 passageiros" em "Veículo"
    E eu seleciono "Aula de Campo" em "Objetivo"
    E eu preencho "Passageiros:" com "Zina, Ronaldo e Alfinete"
    E eu preencho "Roteiro:" com "Ir ao Pacaembu"
    E eu marco "Li e concordo com os termos"
    E eu pressiono "Enviar requisição"
    Então eu devo ver "Requisição enviada com sucesso!"
    Quando "ronaldo@corinthians.com" abre o e-mail
    Então eu devo ver o e-mail enviado por "Astran <teste@email.com>"


  Cenário: Enviar e-mail pelo e-mail definido quando aceitar uma requisição
    Dado que eu tenho uma configuração inicial
    E que a instituição tem o e-mail "teste@email.com"
    E que eu sou um usuário administrador logado
    E que eu tenho uma requisição com estado "Em Espera" e id "25"
    E que eu tenho um motorista com nome "Gustavo Santos"
    E que eu tenho um motorista com nome "Eduardo Silva"
    E que eu tenho um motorista com nome "Pedro Correia"
    E que eu estou na página de detalhes da requisição
    Quando eu clico em "Aceitar"
    Então eu devo estar na página de aceitar requisição
    Quando eu escolho "Nova"
    E eu preencho "Data de saída" com a data daqui a "0" dias
    E eu preencho "Data de chegada" com a data daqui a "5" dias
    E eu seleciono "Gustavo Santos" em "Motoristas"
    E eu seleciono "Eduardo Silva" em "Motoristas"
    E eu seleciono "Pedro Correia" em "Motoristas"
    E eu pressiono "Concluir"
    Quando "fulano@uenf.br" abre o e-mail
    Então eu devo ver o e-mail enviado por "Astran <teste@email.com>"


  Cenário: Enviar e-mail pelo e-mail definido quando a requisição for rejeitada
    Dado que eu tenho uma configuração inicial
    E que a instituição tem o e-mail "teste@email.com"
    E que eu sou um usuário administrador logado
    E que eu tenho uma requisição com estado "Em Espera" e id "25"
    E que eu tenho um motivo com descrição "Falta de carros"
    E que eu estou na página de detalhes da requisição
    Quando eu clico em "Rejeitar"
    E eu seleciono "Falta de carros" em "Motivo"
    E eu preencho "Corpo do E-mail" com "Meu e-mail"
    E eu preencho "Destinatários" com "eduardohertz@gmail.com"
    E eu pressiono "Rejeitar requisição"
    Quando "fulano@uenf.br" abre o e-mail
    Então eu devo ver o e-mail enviado por "Astran <teste@email.com>"


  Cenário: Enviar e-mail pelo e-mail definido quando a requisição for cancelada pelo professor
    Dado que eu tenho uma configuração inicial
    E que a instituição tem o e-mail "teste@email.com"
    E que eu tenho uma requisição do solicitante com matricula "01210" e com o nome "Carlos"
    E que eu estou na página de cancelamento de requisição
    Quando eu preencho "Motivo do cancelamento" com "Algum motivo"
    E eu pressiono "Cancelar requisição"
    Quando "teste@email.com" abre o e-mail
    Então eu devo ver o e-mail enviado por "Astran <teste@email.com>"

  Cenário: Excluir a viagem se apenas a requisição cancelada é atendida pela viagem
    Dado que eu tenho uma configuração inicial
    E que a instituição tem o e-mail "teste@email.com"
    E que eu sou um usuário administrador logado
    E que eu tenho uma requisição com estado "Aceita" e id "25"
    E que eu tenho um motivo com descrição "Falta de verba"
    E que eu tenho uma viagem com o estado "Aguardando"
    E que a requisição esteja ligada à viagem
    E que eu estou na página de detalhes da requisição
    Quando eu clico em "Cancelar requisição"
    E eu seleciono "Falta de verba" em "Motivo"
    E eu preencho "Corpo do E-mail" com "Algumas observações"
    E eu preencho "Destinatários" com "astran@uenf.br"
    E eu pressiono "Cancelar requisição"
    Quando "fulano@uenf.br" abre o e-mail
    Então eu devo ver o e-mail enviado por "Astran <teste@email.com>"
    Quando "astran@uenf.br" abre o e-mail
    Então eu devo ver o e-mail enviado por "Astran <teste@email.com>"

