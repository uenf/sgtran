#language: pt

Funcionalidade: Fechar viagem com o BDT
    Como um administrador
    Eu quero fechar uma viagem com o BDT
    Para que eu finalizar o ciclo de uma ou mais requisições, e com esses dados fazer relatórios mais completos

  Esquema do Cenário: Fechar uma viagem com o BDT
    Dado que eu tenho uma requisição com estado "Aceita"
    E que eu tenho uma viagem com o estado "Aguardando"
    E que eu tenho um veículo de modelo "Corsa" e placa "LCD-6969"
    E que este veiculo esteja ligado à viagem
    E que eu tenho um motorista com nome "Gustavo Ribeiro"
    E que este motorista esteja ligado à viagem
    E que a requisição esteja ligada à viagem
    E que eu estou na página de visualização da viagem
    Quando eu clico em "Fechar viagem"
    Então eu devo estar na página de criação do BDT
    E eu devo ver "Corsa - LCD-6969" selecionado em "Veículo"
    E eu devo ver "Gustavo Ribeiro" selecionado em "Condutor"

    Quando eu preencho "Número físico" com "<numero>"
    E eu preencho "bdt_data_partida" com "<data_partida>"
    E eu seleciono "<horario_partida>" no campo hora "Horário de partida"
    E eu preencho "bdt_odometro_partida" com "<odometro_partida>"
    E eu preencho "bdt_data_recolhimento" com "<data_recolhimento>"
    E eu seleciono "<horario_recolhimento>" no campo hora "Horário de recolhimento"
    E eu preencho "bdt_odometro_recolhimento" com "<odometro_recolhimento>"
    E eu preencho "Local origem" com "Campos"
    E eu preencho "Local destino" com "Rio de Janeiro"
    E eu preencho "Objetivo" com "Ir ao Rio para levar alunos ao aeroporto"
    E eu pressiono "Criar"
    Então eu devo ver "<sentença>"

    Exemplos: (Sucesso)
    | numero | data_partida | horario_partida | odometro_partida | data_recolhimento | horario_recolhimento | odometro_recolhimento | sentença                |
    | 15     | 15/02/2010   | 10:15           | 1480             | 20/02/2010        | 22:38                | 1580                  | Bdt criado com sucesso. |

    Exemplos: (Erro de validação)
    | numero | data_partida | horario_partida | odometro_partida | data_recolhimento | horario_recolhimento | odometro_recolhimento | sentença                                                    |
    |        | 15/02/2010   | 10:15           | 1480             | 20/02/2010        | 22:38                | 1580                  | Número não pode ser vazio                                   |
    | 15     |              | 10:15           | 1480             | 20/02/2010        | 22:38                | 1580                  | Data de partida é inválida                                  |
    | 15     | 15/02/2010   |                 | 1480             | 20/02/2010        | 22:38                | 1580                  | Horário de partida é inválido                               |
    | 15     | 15/02/2010   | 10:15           |                  | 20/02/2010        | 22:38                | 1580                  | Odômetro de partida não pode ser vazio                      |
    | 15     | 15/02/2010   | 10:15           | 1480             |                   | 22:38                | 1580                  | Data de recolhimento é inválida                             |
    | 15     | 15/02/2010   | 10:15           | 1480             | 20/02/2010        |                      | 1580                  | Horário de recolhimento é inválido                          |
    | 15     | 15/02/2010   | 10:15           | 1480             | 20/02/2010        | 22:38                |                       | Odômetro de recolhimento não pode ser vazio                 |
    | 15     | 15/02/2010   | 10:15           | 1780             | 20/02/2010        | 22:38                | 1580                  | Odômetro de recolhimento deve ser maior do que o de partida |




  Cenário: Editar um BDT
    Dado que eu tenho uma requisição com estado "Aceita"
    E que eu tenho uma viagem com o estado "Aguardando"
    E que eu tenho um veículo de modelo "Corsa" e placa "LCD-6969"
    E que eu tenho um veículo de modelo "Corsa" e placa "LLL-1111"
    E que este veiculo esteja ligado à viagem
    E que eu tenho um motorista com nome "Ronaldo"
    E que eu tenho um motorista com nome "Gustavo Ribeiro"
    E que este motorista esteja ligado à viagem
    E que a requisição esteja ligada à viagem
    E que eu tenho um BDT
    E que o BDT esteja ligado à viagem
    E que eu estou na página de visualização do BDT
    Quando eu clico em "Editar"
    Então eu devo estar na página de edição do BDT
    Quando eu preencho "Número físico" com "15"
    E eu seleciono "Ronaldo" em "Condutor"
    E eu seleciono "Corsa - LCD-6969" em "Veículo"
    E eu preencho "bdt_data_partida" com "15/02/2010"
    E eu seleciono "11:32" no campo hora "Horário de partida"
    E eu preencho "bdt_odometro_partida" com "1480"
    E eu preencho "bdt_data_recolhimento" com "20/02/2010"
    E eu seleciono "23:16" no campo hora "Horário de recolhimento"
    E eu preencho "bdt_odometro_recolhimento" com "1580"
    E eu preencho "Objetivo" com "Ir ao Rio para levar alunos ao aeroporto"
    E eu preencho "Local origem" com "Campos"
    E eu preencho "Local destino" com "Rio de Janeiro"
    E eu pressiono "Atualizar"
    Então eu devo ver "BDT atualizado com sucesso."
    E eu devo estar na página de visualização do BDT
    E eu devo ver "Condutor: Ronaldo"
    E eu devo ver "Veículo: Corsa - LCD-6969"

