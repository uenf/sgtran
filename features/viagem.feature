# language: pt

Funcionalidade: Editar viagem

Como um administrador
Eu quero editar uma viagem
Para que eu possa mudar seus dados de acordo com a dinâmica do trabalho

  Cenário: Editar viagem com mais de um motorista
    Dado que eu sou um usuário administrador logado
    E que eu tenho uma requisição com estado "Aceita" e id "25"
    E que eu tenho uma viagem com o estado "Aguardando"
    # Essa viagem já tem o motorista Gustavo Ribeiro
    E que a requisição esteja ligada à viagem
    E que eu tenho um motorista com nome "Eduardo Silva"
    E que este motorista esteja ligado à viagem
    E que eu tenho um motorista com nome "Pedro Correia"
    E que este motorista esteja ligado à viagem
    E que eu estou na página de edição de viagem
    Quando eu seleciono "Eduardo Silva" em "Motoristas:"
    E eu seleciono "Pedro Correia" em "Motoristas:"
    E eu pressiono "Salvar"
    Então eu devo ver "Viagem atualizada com sucesso!"
    E eu devo ver "Motoristas: Gustavo Ribeiro, Eduardo Silva e Pedro Correia"
    E eu devo ver "Estado: Aguardando"

  Esquema do Cenário: Fechar uma viagem com estado Aguardando e com requisição em estado Cancelada
    Dado que eu sou um usuário administrador logado
    E que eu tenho uma requisição com estado "Aceita" e id "15"
    E que eu tenho uma viagem com o estado "Aguardando"
    E que a requisição esteja ligada à viagem
    E que eu tenho um veículo de modelo "Corsa" e placa "LCD-6969"
    E que este veiculo esteja ligado à viagem
    E que eu tenho um motorista com nome "Gustavo Ribeiro"
    E que este motorista esteja ligado à viagem
    E que eu estou na página de visualização da viagem
    Quando eu clico em "Fechar viagem"
    Então eu devo estar na página de criação do BDT
    E eu devo ver "Corsa - LCD-6969" selecionado em "Veículo"
    E eu devo ver "Gustavo Ribeiro" selecionado em "Condutores"
    Dado que eu tenho uma requisição com estado "<Estado>" e id "17"
    E que a requisição esteja ligada à viagem
    E que eu estou na página de visualização da viagem
    Quando eu clico em "Fechar viagem"

    Então eu devo estar na página de criação do BDT
    Quando eu preencho "Número" com "28"
    E eu preencho "bdt_data_partida" com "15/02/2010"
    E eu preencho "bdt_odometro_partida" com "15020"
    E eu preencho "bdt_data_recolhimento" com "16/02/2010"
    E eu preencho "bdt_odometro_recolhimento" com "15810"
    E eu pressiono "Salvar"

    Então a viagem deve estar atendida
    E a requisição deve estar <Tipo de cancelamento>
    E o bdt deve estar ligado à viagem

  Exemplos:
    | Estado                    | Tipo de cancelamento      |
    | Cancelado pelo sistema    | cancelada pelo sistema    |
    | Cancelado pelo professor  | cancelada pelo professor  |


  Cenário: Cancelar a viagem com uma requisição aceita com data anterior a hoje
    Dado que eu sou um usuário administrador logado
    E que eu tenho uma requisição de "2" dias atrás e com estado "Aceita"
    E que eu tenho uma viagem com o estado "Aguardando"
    E que a requisição esteja ligada à viagem
    E que eu tenho um motivo com descrição "Não há carro disponível"
    E que eu estou na página de visualização da viagem
    Quando eu clico em "Cancelar viagem"
    E eu seleciono "Não há carro disponível" em "Motivo do cancelamento"
    E eu pressiono "Cancelar viagem"
    Então a requisição deve estar cancelada pelo sistema
    E a viagem deve estar cancelada
    E a requisição deve estar ligada a uma viagem

  Cenário: Listar as viagens atendidas para terem o bdt preenchido
    Dado que eu sou um usuário administrador logado
    E que eu tenho uma requisição de "2" dias atrás e com estado "Aceita"
    E que eu tenho uma viagem com o estado "Aguardando"
    E que a requisição esteja ligada à viagem
    E que eu tenho uma requisição de "2" dias atrás e com estado "Finalizada"
    E que eu tenho uma viagem com o estado "Atendida"
    E que a requisição esteja ligada à viagem
    E que eu estou na página de visualização de viagens sem bdt
    Então eu devo ver "Atendida"
    E eu não devo ver "Aguardando"

