# language: pt

Funcionalidade: Aceitar requisição de viagem

    Como um administrador
    Eu quero aceitar uma requisição de viagem
    Para que o professor possa ter sua requisição executada

    Esquema do Cenário: Aceitar requisição
    Dado que eu tenha uma requisição em espera
    E que eu tenho "Gustavo Santos" em Motorista
    E que eu tenho "Eduardo Silva" em Motorista
    E que eu estou na página de detalhes da requisição

    Quando eu clico em "Aceitar"
    Então eu devo estar na página de editar detalhes da viagem

    Quando eu escolho "Atender com uma nova viagem"
    E eu preencho "Data de saída" com a data "<data de saída>"
    E eu preencho "Data de chegada" com a data "<data de chegada>"
    E eu seleciono "<horario>" no campo hora "Horário de saída"
    E eu seleciono "<motorista_selecao>" em "Motorista"

    E eu pressiono "Concluir"

    Então eu devo ver "Data de saída: " com a data "<data de saída>"
    E eu devo ver "Data de chegada: " com a data "<data de chegada>"
    E eu devo ver "Horário de partida: <horario>"
    E eu devo ver "Motorista: <motorista_visao>"
    E eu devo ver "Estado: Aguardando"

    Exemplos: (preenchimento dos dados da viagem)

    | data de saída   | data de chegada | horario | motorista_selecao       | motorista_visao   |
    |                 | Daqui a 2 dias  | 13:00   | Gustavo Santos          | Gustavo Santos    |
    | Daqui a 2 dias  |                 | 14:00   | Gustavo Santos          | Gustavo Santos    |
    | Daqui a 2 dias  | Daqui a 2 dias  | 13:00   | Selecione um motorista  |                   |
    | Daqui a 2 dias  |                 | 10:00   | Eduardo Silva           | Eduardo Silva     |
    |                 |                 | 10:00   | Selecione um motorista  |                   |


    Esquema do Cenário: Aceitar com uma viagem já existente
      Dado que eu tenha uma viagem
      E que eu tenha uma requisição em espera
      E que eu estou na página de detalhes da requisição
      Quando eu clico em "Aceitar"
      Então eu devo estar na página de editar detalhes da viagem
      Quando eu escolho "Atender com uma viagem já existente"
      E <ação>
      E eu pressiono "Concluir"
      Então <resposta>

      Exemplos:
        | ação                          | resposta                                           |
        | eu escolho a viagem existente | eu devo estar na página de visualização da viagem |
        | eu não escolho nenhuma viagem | eu devo ver "Viagem não foi selecionada"           |

