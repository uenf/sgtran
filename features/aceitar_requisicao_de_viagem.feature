# language: pt

Funcionalidade: Aceitar requisição de viagem

    Como um administrador
    Eu quero aceitar uma requisição de viagem
    Para que o professor possa ter sua requisição executada

    Esquema do Cenário: Aceitar requisição com uma nova viagem
      Dado que eu tenho uma requisição com estado "Em Espera"
      E que eu tenha "Gustavo Santos" em Motorista
      E que eu tenha "Eduardo Silva" em Motorista
      E que eu tenha um veículo da categoria "Automóvel até 4 passageiros", modelo "Gol" e placa "KQI 5899"
      E que eu estou na página de detalhes da requisição

      Quando eu clico em "Aceitar"
      Então eu devo estar na página de aceitar requisição

      Quando eu escolho "Nova"
      E eu preencho "Data de saída" com a data daqui a "<data de saída>" dias
      E eu preencho "Data de chegada" com a data daqui a "<data de chegada>" dias
      E eu seleciono "<horario>" no campo hora "Horário de saída"
      E eu seleciono "<motorista_selecao>" em "Motorista"
      E eu seleciono "<veiculo_selecao>" em "Veículo"

      E eu pressiono "Concluir"

      Então eu devo ver "Data de saída: " com a data daqui a "<data de saída>" dias
      E eu devo ver "Data de chegada: " com a data daqui a "<data de chegada>" dias
      E eu devo ver "Horário de partida: <horario>"
      E eu devo ver "Motorista: <motorista_visao>"
      E eu devo ver "Veículo: <veiculo_visao>"
      E eu devo ver "Estado: Aguardando"

        Exemplos: (preenchimento dos dados da viagem)

        | data de saída   | data de chegada | horario | motorista_selecao       | motorista_visao   | veiculo_selecao                               | veiculo_visao                                  |
        | 0               | 2               | 13:00   | Gustavo Santos          | Gustavo Santos    | Gol - KQI 5899 - Automóvel até 4 passageiros  | Gol - KQI 5899 - Automóvel até 4 passageiros   |
        | 2               | 2               | 13:00   | Selecione um motorista  |                   | Gol - KQI 5899 - Automóvel até 4 passageiros  | Gol - KQI 5899 - Automóvel até 4 passageiros   |
        | 0               | 0               | 10:00   | Selecione um motorista  |                   | Gol - KQI 5899 - Automóvel até 4 passageiros  | Gol - KQI 5899 - Automóvel até 4 passageiros   |
        | 0               | 0               | 10:00   | Gustavo Santos          | Gustavo Santos    | Selecione um veículo                          |                                                |
        | 0               | 0               | 10:00   | Gustavo Santos          | Gustavo Santos    | Gol - KQI 5899 - Automóvel até 4 passageiros  | Gol - KQI 5899 - Automóvel até 4 passageiros  |


    Esquema do Cenário: Aceitar com uma viagem já existente
      Dado que eu tenho uma requisição com estado "Em Espera"
      E que eu tenha uma viagem
      E que eu estou na página de detalhes da requisição
      Quando eu clico em "Aceitar"
      Então eu devo estar na página de aceitar requisição
      Quando eu escolho "Existente"
      E <ação>
      E eu pressiono "Concluir"
      Então <resposta>

      Exemplos:
        | ação                          | resposta                                           |
        | eu escolho a viagem existente | eu devo estar na página de visualização da viagem  |
        | eu não escolho nenhuma viagem | eu devo ver "Viagem não foi selecionada"           |


    Cenário: Aceitar uma requisição apenas se o estado for Em Espera
      Dado que eu tenho uma requisição com estado "Cancelada pelo Sistema"
      E que eu estou na página de aceitar a requisição
      Então eu devo ver "A requisição deve estar no estado 'Em Espera' para ser aceita"
      E eu devo estar na página de detalhes da requisição


    Cenário: Data de chegada anterior à data de partida
      Dado que eu tenho uma requisição com estado "Em Espera"
      E que eu estou na página de detalhes da requisição

      Quando eu clico em "Aceitar"
      Então eu devo estar na página de aceitar requisição

      Quando eu escolho "Nova"
      E eu preencho "Data de saída" com a data daqui a "2" dias
      E eu preencho "Data de chegada" com a data daqui a "<0>" dias
      E eu pressiono "Concluir"
      Então eu devo ver "Data de chegada anterior à data de partida"

