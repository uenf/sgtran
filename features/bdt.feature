#language: pt

Funcionalidade: Fechar viagem com o BDT
    Como um administrador
    Eu quero fechar uma viagem com o BDT
    Para que eu finalizar o ciclo de uma ou mais requisições, e com esses dados fazer relatórios mais completos

  Cenário: Fechar uma viagem com o BDT
    Dado que eu tenho uma requisição com estado "Aceita"
    E que eu tenho uma viagem com o estado "Aguardando"
    E que eu tenho um veículo com prefixo "1", ordem "13", placa "LCD-6969" e modelo "Corsa"
    E que este veiculo esteja ligado à viagem
    E que eu tenho um motorista com nome "Gustavo Ribeiro" e matricula "123456"
    E que este motorista esteja ligado à viagem
    E que a requisição esteja ligada à viagem
    E que eu estou na página de visualização da viagem
    Quando eu clico em "Fechar viagem"
    Então eu devo estar na página de criação do BDT
    E eu devo ver "1 - 13 - LCD-6969 - Corsa" selecionado em "Veículo"
    E eu devo ver "Gustavo Ribeiro - 123456" selecionado em "Condutor"

    Quando eu preencho "Odômetro recolhimento" com "1580"
    E eu preencho "Odômetro partida" com "1480"
    E eu preencho "Objetivo" com "Ir ao Rio para levar alunos ao aeroporto"
    E eu preencho "Local origem" com "Campos"
    E eu preencho "Local destino" com "Rio de Janeiro"
    E eu preencho "Número" com "15"
    E eu preencho "Partida" com "15/02/2010"
    E eu preencho "Recolhimento" com "20/02/2010"
    E eu pressiono "Criar"
    Então eu devo ver "Bdt criado com sucesso."

  Cenário: Editar um BDT
    Dado que eu tenho uma requisição com estado "Aceita"
    E que eu tenho uma viagem com o estado "Aguardando"
    E que eu tenho um veículo com prefixo "1", ordem "13", placa "LCD-6969" e modelo "Corsa"
    E que este veiculo esteja ligado à viagem
    E que eu tenho um motorista com nome "Gustavo Ribeiro" e matricula "123456"
    E que este motorista esteja ligado à viagem
    E que a requisição esteja ligada à viagem
    E que eu tenho um BDT
    E que o BDT esteja ligado à viagem
    E que eu estou na página de visualização do BDT
    Quando eu clico em "Editar"
    Então eu devo estar na página de edição do BDT
    Quando eu preencho "Odômetro recolhimento" com "1580"
    E eu preencho "Odômetro partida" com "1480"
    E eu preencho "Objetivo" com "Ir ao Rio para levar alunos ao aeroporto"
    E eu preencho "Local origem" com "Campos"
    E eu preencho "Local destino" com "Rio de Janeiro"
    E eu preencho "Número" com "15"
    E eu preencho "Partida" com "15/02/2010"
    E eu preencho "Recolhimento" com "20/02/2010"
    E eu pressiono "Atualizar"

