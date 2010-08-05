# language: pt

Funcionalidade: Editar viagem

Como um administrador
Eu quero editar uma viagem
Para que eu possa mudar seus dados de acordo com a dinâmica do trabalho

  Esquema do Cenário: Editar viagem
    Dado que eu tenho uma requisição com estado "Aceita" e id "25"
    E que eu tenho uma viagem com o estado "Aguardando"
    E que a requisição esteja ligada à viagem
    E que eu tenho um motorista com nome "Gustavo Santos"
    E que eu tenha um veículo da categoria "Automóvel até 4 passageiros", modelo "Gol" e placa "KQI 5899"
    E que eu estou na página de edição de viagem

    Quando eu preencho "Data de saída:" com a data daqui a "<data de saída>" dias
    E eu preencho "Data de chegada:" com a data daqui a "<data de chegada>" dias
    E eu seleciono "<horario>" no campo hora "Horário de saída:"
    E eu seleciono "<motorista>" em "Motorista:"
    E eu seleciono "<veiculo>" em "Veículo:"
    E eu pressiono "Atualizar"

    Então eu devo ver "<sentença>"
    E eu devo ver "Data de chegada: " com a data daqui a "<data de chegada>" dias
    E eu devo ver "Horário de partida: <horario>"
    E eu devo ver "Motorista: <motorista>"
    E eu devo ver "Veículo: <veiculo>"
    E eu devo ver "Estado: Aguardando"

    Exemplos: (Campos válidos)
        | data de saída | data de chegada | horario | motorista      | veiculo                                      | sentença                       |
        | 1             | 3               | 11:25   | Gustavo Santos | Gol - KQI 5899 - Automóvel até 4 passageiros | Viagem atualizada com sucesso! |

    Exemplos: (Campos inválidos)
        | data de saída | data de chegada | horario | motorista      | veiculo                                      | sentença                       |
        | -1            | -1              | 13:00   | Gustavo Santos | Gol - KQI 5899 - Automóvel até 4 passageiros | Viagem atualizada com sucesso! |

  Esquema do Cenário: Fechar uma viagem com estado Aguardando e com requisição em estado Cancelada
    Dado que eu tenho uma requisição com estado "Aceita" e id "15"
    E que eu tenho uma viagem com o estado "Aguardando"
    E que a requisição esteja ligada à viagem
    E que eu tenho um veículo de modelo "Corsa" e placa "LCD-6969"
    E que este veiculo esteja ligado à viagem
    E que eu tenho um motorista com nome "Gustavo Ribeiro"
    E que este motorista esteja ligado à viagem
    E que eu tenho a cidade "Campos dos Goytacazes" do "RJ"
    E que eu tenho a cidade "Macaé" do "RJ"
    E que eu estou na página de visualização da viagem
    Quando eu clico em "Fechar viagem"
    Então eu devo estar na página de criação do BDT
    E eu devo ver "Corsa - LCD-6969" selecionado em "Veículo"
    E eu devo ver "Gustavo Ribeiro" selecionado em "Condutor"
    E que eu tenho uma requisição com estado "<Estado>" e id "17"
    E que a requisição esteja ligada à viagem
    E que eu estou na página de visualização da viagem
    Quando eu clico em "Fechar viagem"

    Então eu devo estar na página de criação do BDT
    Quando eu preencho "Número" com "28"
    E eu preencho "bdt_data_partida" com "15/02/2010"
    E eu seleciono "08:10:00" no campo hora "Horário de partida"
    E eu preencho "bdt_odometro_partida" com "15020"
    E eu preencho "bdt_data_recolhimento" com "16/02/2010"
    E eu seleciono "23:28:00" no campo hora "Horário de recolhimento"
    E eu preencho "bdt_odometro_recolhimento" com "15810"
    E eu seleciono "RJ" em "estado_origem[15]"
    E eu seleciono "Campos dos Goytacazes" em "cidade_origem[15]"
    E eu seleciono "RJ" em "estado_destino[15]"
    E eu seleciono "Macaé" em "cidade_destino[15]"
    E eu seleciono "RJ" em "estado_origem[17]"
    E eu seleciono "Macaé" em "cidade_origem[17]"
    E eu seleciono "RJ" em "estado_destino[17]"
    E eu seleciono "Campos dos Goytacazes" em "cidade_destino[17]"
    E eu pressiono "Criar"

    Então a viagem deve estar atendida
    E a requisição deve estar <Tipo de cancelamento>
    E o bdt deve estar ligado à viagem

  Exemplos:
    | Estado                    | Tipo de cancelamento      |
    | Cancelado pelo sistema    | cancelada pelo sistema    |
    | Cancelado pelo professor  | cancelada pelo professor  |


  Cenário: Cancelar a viagem com uma requisição aceita com data anterior a hoje
    Dado que eu tenho uma requisição de "2" dias atrás e com estado "Aceita"
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

