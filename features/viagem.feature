# language: pt

Funcionalidade: Editar viagem

Como um administrador
Eu quero editar uma viagem
Para que eu possa mudar seus dados de acordo com a dinâmica do trabalho

  Esquema do Cenário: Editar viagem
    Dado que eu tenho uma requisição com estado "Aceita"
    E que eu tenho uma viagem com o estado "Aguardando"
    E que a requisição esteja ligada à viagem
    E que exista um motorista com nome "Gustavo Santos"
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

    Exemplos:

        | data de saída   | data de chegada | horario | motorista           | veiculo                                       | sentença                         |
        | 1               | 3               | 13:00   | Gustavo Santos      | Gol - KQI 5899 - Automóvel até 4 passageiros  | Viagem atualizada com sucesso!   |
        
        
  Cenário: Fechar uma viagem com estado Aguardando
    Dado que eu tenho uma requisição com estado "Aceita"
    E que eu tenho uma viagem com o estado "Aguardando"
    E que a requisição esteja ligada à viagem
    E que eu estou na página de visualização da viagem
    Quando eu clico em "Fechar viagem"
    E eu pressiono "Fechar viagem"
    Então eu devo estar na página de visualização da viagem
    E eu devo ver "Estado: Atendida"
        

