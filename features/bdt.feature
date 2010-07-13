#language: pt

Funcionalidade: Fechar viagem com o BDT
    Como um administrador
    Eu quero fechar uma viagem com o BDT
    Para que eu finalizar o ciclo de uma ou mais requisições, e com esses dados fazer relatórios mais completos

  Esquema do Cenário: Fechar uma viagem com o BDT
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

    Quando eu preencho "Número" com "<numero>"
    E eu preencho "partida_data" com "<data_partida>"
    E eu seleciono "<horario_partida>" no campo hora "Horário de partida"
    E eu preencho "bdt_odometro_partida" com "<odometro_partida>"
    E eu preencho "recolhimento_data" com "<data_recolhimento>"
    E eu seleciono "<horario_recolhimento>" no campo hora "Horário de recolhimento"
    E eu preencho "bdt_odometro_recolhimento" com "<odometro_recolhimento>"
    E eu preencho "Local origem" com "<local_origem>"
    E eu preencho "Local destino" com "<local_destino>"
    E eu preencho "Objetivo" com "<objetivo>"
    E eu pressiono "Criar"
    Então eu devo ver "<sentença>"
#    E eu devo ver ""
#    Então show me the page

    Exemplos: (Sucesso)
    | numero | data_partida | horario_partida | odometro_partida | data_recolhimento | horario_recolhimento | odometro_recolhimento | local_origem | local_destino  | objetivo                                 | sentença                |
    | 15     | 15/02/2010   | 10:15           | 1480             | 20/02/2010        | 22:38                | 1580                  | Campos       | Rio de Janeiro | Ir ao Rio para levar alunos ao aeroporto | Bdt criado com sucesso. |

    Exemplos: (Erro de validação)
    | numero | data_partida | horario_partida | odometro_partida | data_recolhimento | horario_recolhimento | odometro_recolhimento | local_origem | local_destino  | objetivo                                 | sentença                                    |
    |        | 15/02/2010   | 10:15           | 1480             | 20/02/2010        | 22:38                | 1580                  | Campos       | Rio de Janeiro | Ir ao Rio para levar alunos ao aeroporto | Número não pode ser vazio                   |
    | 15     |              | 10:15           | 1480             | 20/02/2010        | 22:38                | 1580                  | Campos       | Rio de Janeiro | Ir ao Rio para levar alunos ao aeroporto | Data de partida não pode ser vazia          |
    | 15     | 15/02/2010   |                 | 1480             | 20/02/2010        | 22:38                | 1580                  | Campos       | Rio de Janeiro | Ir ao Rio para levar alunos ao aeroporto | Horário de partida não pode ser vazio       |
    | 15     | 15/02/2010   | 10:15           |                  | 20/02/2010        | 22:38                | 1580                  | Campos       | Rio de Janeiro | Ir ao Rio para levar alunos ao aeroporto | Odômetro de partida não pode ser vazio      |
    | 15     | 15/02/2010   | 10:15           | 1480             |                   | 22:38                | 1580                  | Campos       | Rio de Janeiro | Ir ao Rio para levar alunos ao aeroporto | Data de recolhimento não pode ser vazia     |
    | 15     | 15/02/2010   | 10:15           | 1480             | 20/02/2010        |                      | 1580                  | Campos       | Rio de Janeiro | Ir ao Rio para levar alunos ao aeroporto | Horário de recolhimento não pode ser vazio  |
    | 15     | 15/02/2010   | 10:15           | 1480             | 20/02/2010        | 22:38                |                       | Campos       | Rio de Janeiro | Ir ao Rio para levar alunos ao aeroporto | Odômetro de recolhimento não pode ser vazio |

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

