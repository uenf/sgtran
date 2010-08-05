# language: pt

Funcionalidade: Informar o local de origem e destino da requisição

    Como um administrador
    Eu quero saber qual o local de origem e destino das requisições
    Para que eu possa fazer relatórios com essas informações

  Cenário: Linkar duas requisições com seu local de origem e destino informados na página de edição do BDT
    Dado que eu tenho um conjunto de requisições
    E que eu tenho uma requisição com estado "Aceita" e id "15"
    E que eu tenho uma viagem com o estado "Aceita"
    E que eu tenho um veículo de modelo "Corsa" e placa "LCD-6969"
    E que este veiculo esteja ligado à viagem
    E que eu tenho um motorista com nome "Ronaldo"
    E que este motorista esteja ligado à viagem
    E que a requisição esteja ligada à viagem
    E que a requisição esteja no meu conjunto de requisições
    E que eu tenho uma requisição com estado "Aceita" e id "17"
    E que a requisição esteja ligada à viagem
    E que a requisição esteja no meu conjunto de requisições
    E que eu tenho um BDT
    E que o BDT esteja ligado à viagem

    E que eu tenho a cidade "Campos dos Goytacazes" do "RJ"
    E que eu tenho a cidade "Macaé" do "RJ"
    E que eu tenho a cidade "Rio de Janeiro" do "RJ"
    E que eu tenho a cidade "Rio das Ostras" do "RJ"
    E que eu estou na página de edição do BDT

    Quando eu seleciono "RJ" em "estado_origem[15]"
    E eu seleciono "Campos dos Goytacazes" em "cidade_origem[15]"
    E eu seleciono "RJ" em "estado_destino[15]"
    E eu seleciono "Rio de Janeiro" em "cidade_destino[15]"

    E eu seleciono "RJ" em "estado_origem[17]"
    E eu seleciono "Macaé" em "cidade_origem[17]"
    E eu seleciono "RJ" em "estado_destino[17]"
    E eu seleciono "Rio das Ostras" em "cidade_destino[17]"

    E eu pressiono "Atualizar"
    Então o local de origem da requisição com id "15" deve ser "Campos dos Goytacazes" do "RJ"
    E o local de origem da requisição com id "17" deve ser "Macaé" do "RJ"
    E o local de destino da requisição com id "15" deve ser "Rio de Janeiro" do "RJ"
    E o local de destino da requisição com id "17" deve ser "Rio das Ostras" do "RJ"

  Cenário: Linkar duas requisições com seu local de origem e destino informados na página de adição do BDT
    Dado que eu tenho uma viagem com o estado "Aguardando"
    E que eu tenho um conjunto de requisições
    E que eu tenho uma requisição com estado "Aceita" e id "15"
    E que a requisição esteja ligada à viagem
    E que a requisição esteja no meu conjunto de requisições
    E que eu tenho uma requisição com estado "Aceita" e id "17"
    E que a requisição esteja ligada à viagem
    E que a requisição esteja no meu conjunto de requisições
    E que eu tenho um veículo de modelo "Corsa" e placa "LCD-6969"
    E que este veiculo esteja ligado à viagem
    E que eu tenho um motorista com nome "Gustavo Ribeiro"
    E que este motorista esteja ligado à viagem
    E que eu tenho a cidade "Campos dos Goytacazes" do "RJ"
    E que eu tenho a cidade "Macaé" do "RJ"
    E que eu tenho a cidade "Rio de Janeiro" do "RJ"
    E que eu tenho a cidade "Rio das Ostras" do "RJ"
    E que eu estou na página de visualização da viagem
    Quando eu clico em "Fechar viagem"
    Então eu devo estar na página de criação do BDT
    E eu devo ver "Corsa - LCD-6969" selecionado em "Veículo"
    E eu devo ver "Gustavo Ribeiro" selecionado em "Condutor"

    Quando eu preencho "Número físico" com "15"
    E eu preencho "bdt_data_partida" com "15/02/2010"
    E eu seleciono "08:45" no campo hora "Horário de partida"
    E eu preencho "bdt_odometro_partida" com "1250"
    E eu preencho "bdt_data_recolhimento" com "17/02/2010"
    E eu seleciono "10:20" no campo hora "Horário de recolhimento"
    E eu preencho "bdt_odometro_recolhimento" com "1530"
    E eu preencho "Objetivo" com "Ir ao Rio para levar alunos ao aeroporto"

    E eu seleciono "Campos dos Goytacazes" em "cidade_origem[15]"
    E eu seleciono "RJ" em "estado_destino[15]"
    E eu seleciono "Rio de Janeiro" em "cidade_destino[15]"

    E eu seleciono "RJ" em "estado_origem[17]"
    E eu seleciono "Macaé" em "cidade_origem[17]"
    E eu seleciono "RJ" em "estado_destino[17]"
    E eu seleciono "Rio das Ostras" em "cidade_destino[17]"
    E eu pressiono "Criar"

    Então eu devo ver "Bdt criado com sucesso."
    E o local de origem da requisição com id "15" deve ser "Campos dos Goytacazes" do "RJ"
    E o local de destino da requisição com id "15" deve ser "Rio de Janeiro" do "RJ"
    E o local de origem da requisição com id "17" deve ser "Macaé" do "RJ"
    E o local de destino da requisição com id "17" deve ser "Rio das Ostras" do "RJ"
    E eu devo ver "Requisição 15: Campos dos Goytacazes - Rio de Janeiro"
    E eu devo ver "Requisição 17: Macaé - Rio das Ostras"

