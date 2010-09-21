# language: pt

Funcionalidade: Aceitar requisição de viagem

    Como um administrador
    Eu quero aceitar uma requisição de viagem
    Para que o professor possa ter sua requisição executada

    Esquema do Cenário: Aceitar requisição com uma nova viagem
      Dado que eu tenho uma requisição com estado "Em Espera" e id "25"
      E que eu tenho um motorista com nome "Gustavo Santos"
      E que eu tenho um motorista com nome "Eduardo Silva"
      E que eu tenha um veículo da categoria "Automóvel até 4 passageiros", modelo "Gol" e placa "KQI 5899"
      E que eu estou na página de detalhes da requisição

      Quando eu clico em "Aceitar"
      Então eu devo estar na página de aceitar requisição

      Quando eu escolho "Nova"
      E eu preencho "Data de saída" com a data daqui a "<data de saída>" dias
      E eu preencho "Data de chegada" com a data daqui a "<data de chegada>" dias
      E eu seleciono "<horario>" no campo hora "Horário de saída"
      E eu seleciono "Gustavo Santos" em "Motoristas"
      E eu seleciono "<veiculo_selecao>" em "Veículo"

      E eu pressiono "Concluir"

      Então eu devo ver "Data de saída: " com a data daqui a "<data de saída>" dias
      E eu devo ver "Data de chegada: " com a data daqui a "<data de chegada>" dias
      E eu devo ver "Horário de partida: <horario>"
      E eu devo ver "Motoristas: Gustavo Santos"
      E eu devo ver "Veículo: <veiculo_visao>"
      E eu devo ver "Estado: Aguardando"

        Exemplos: (preenchimento dos dados da viagem)

        | data de saída | data de chegada | horario | veiculo_selecao                              | veiculo_visao                                |
        | 0             | 2               | 13:00   | Gol - KQI 5899 - Automóvel até 4 passageiros | Gol - KQI 5899 - Automóvel até 4 passageiros |
        | 2             | 2               | 13:00   | Gol - KQI 5899 - Automóvel até 4 passageiros | Gol - KQI 5899 - Automóvel até 4 passageiros |
        | 0             | 0               | 10:00   | Gol - KQI 5899 - Automóvel até 4 passageiros | Gol - KQI 5899 - Automóvel até 4 passageiros |
        | 0             | 0               | 10:00   | Selecione um veículo                         |                                              |

    Cenário: Aceitar requisição com uma nova viagem e mais de um motorista
      Dado que eu tenho uma requisição com estado "Em Espera" e id "25"
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
      Então eu devo ver "Motoristas: Gustavo Santos, Eduardo Silva e Pedro Correia"

    Esquema do Cenário: Aceitar com uma viagem já existente
      Dado que eu tenho uma requisição com estado "Em Espera" e id "25"
      E que eu tenha uma viagem
      E que eu estou na página de detalhes da requisição
      Quando eu clico em "Aceitar"
      Então eu devo estar na página de aceitar requisição
      Quando eu escolho "Existente"
      E <ação>
      E eu pressiono "Concluir"
      Então <resposta>

      Exemplos:
        | ação                          | resposta                                          |
        | eu escolho a viagem existente | eu devo estar na página de visualização da viagem |
        | eu não escolho nenhuma viagem | eu devo ver "Viagem não foi selecionada"          |


    Cenário: Aceitar uma requisição apenas se o estado for Em Espera
      Dado que eu tenho uma requisição com estado "Cancelada pelo Sistema" e id "25"
      E que eu estou na página de aceitar a requisição
      Então eu devo ver "A requisição deve estar no estado 'Em Espera' para ser aceita"
      E eu devo estar na página de detalhes da requisição


    Cenário: Data de chegada anterior à data de partida
      Dado que eu tenho uma requisição com estado "Em Espera" e id "25"
      E que eu tenho um motorista com nome "Gustavo Santos"
      E que eu estou na página de detalhes da requisição
      Quando eu clico em "Aceitar"
      Então eu devo estar na página de aceitar requisição
      Quando eu escolho "Nova"
      E eu preencho "Data de saída" com a data daqui a "2" dias
      E eu preencho "Data de chegada" com a data daqui a "<0>" dias
      E eu pressiono "Concluir"
      Então eu devo ver "Data de chegada anterior à data de partida"

    Cenário: Motorista não selecionado
      Dado que eu tenho uma requisição com estado "Em Espera" e id "25"
      E que eu tenho um motorista com nome "Gustavo Santos"
      E que eu estou na página de detalhes da requisição
      Quando eu clico em "Aceitar"
      Então eu devo estar na página de aceitar requisição
      Quando eu escolho "Nova"
      E eu preencho "Data de saída" com a data daqui a "0" dias
      E eu preencho "Data de chegada" com a data daqui a "2" dias
      E eu pressiono "Concluir"
      Então eu devo ver "Motoristas não pode ser vazio"

    Cenário: Aceitar uma requisição com uma viagem em estado Aguardando
      Dado que eu tenho uma requisição com estado "Em Espera" e id "25"
      E que eu tenho uma viagem com o estado "Aguardando"
      E que eu estou na página de detalhes da requisição
      Quando eu clico em "Aceitar"
      E eu escolho "Existente"
      Então eu devo ver a tabela "viagens" com
          | Data de partida   | Data de chegada   | Horário de partida | Motorista       | Veículo | Requisição(s) atendida(s) | Escolha |
          | Daqui a dois dias | Daqui a dois dias |                    | Gustavo Ribeiro |         | ID                        |         |

    Esquema do Cenário: Não aceitar uma requisição com uma viagem em estado Atendida ou Cancelada
      Dado que eu tenho uma requisição com estado "Em Espera" e id "25"
      E que eu tenho uma viagem com o estado "<Estado>"
      E que eu estou na página de detalhes da requisição
      Quando eu clico em "Aceitar"
      E eu escolho "Existente"
      Então eu devo ver a tabela "viagens" com
          | Data de partida     | Data de chegada   | Horário de partida  | Motorista     | Veículo | Requisição(s) atendida(s) | Escolha   |

      Exemplos:
      | Estado    |
      | Cancelada |
      | Atendida  |

