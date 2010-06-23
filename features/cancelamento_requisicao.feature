# language: pt

Funcionalidade: Cancelar viagem

  Como um professor
  Eu quero cancelar uma requisição de viagem
  Para que eu não viaje mais

  Esquema do Cenário: Cancelamento de requisição
    Dado que eu tenho uma requisição do solicitante com matricula "01210" e com o nome "Carlos"
    E que eu estou na página de cancelamento de requisição
    Então eu devo ver "Motivo do Cancelamento"
    Quando eu preencho "Motivo do Cancelamento" com "<Motivo>"
    E eu pressiono "Cancelar requisição"
    Então eu devo ver "<Sentença>"


    Exemplos:(Requisição cancelada com sucesso)

    | Motivo       | Sentença                          |
    | Estou doente | Requisição cancelada com sucesso! |
    | Faltou verba | Requisição cancelada com sucesso! |

    Exemplos:(Campos vazios)

    | Motivo | Sentença                  |
    |        | Motivo não pode ser vazio |


  Cenário: Cancelamento de requisição com dados incorretos
    Dado que eu tenho uma requisição do solicitante com matricula "01210" e com o nome "Carlos"
    Quando eu vou para página de cancelamento de requisição com id "1" e chave de segurança "123abc"
    Então eu devo ver "Solicitação de reserva de veículos"

  Cenário: Cancelamento de requisição que já foi cancelada
    Dado que eu tenho uma requisição com estado cancelado por motivo de falta de verba
    Quando eu vou para "página de cancelamento de requisição"
    Então eu devo ver "Esta requisição já foi cancelada."

  Cenário: Cancelar a viagem caso a requisição cancelada seja a última
    Dado que eu tenho uma requisição com estado "Aceita"
    E que eu tenho uma viagem com o estado "Aguardando"
    E que a requisição esteja ligada à viagem
    E que eu estou na página de cancelamento de requisição
    Quando eu preencho "Motivo do Cancelamento" com "algum motivo"
    E eu pressiono "Cancelar requisição"
    Então eu devo ver "Requisição cancelada com sucesso!"
    E a viagem deve estar cancelada
    E a viagem não deve ter nenhuma requisição

  Cenário: Cancelar requisição ligada à viagem que possui 2 ou mais requisições
    Dado que eu tenho uma requisição com estado "Aceita"
    E que eu tenho uma viagem com o estado "Aguardando"
    E que a requisição esteja ligada à viagem
    E que eu tenho uma requisição com estado "Aceita"
    E que a requisição esteja ligada à viagem
    E que eu estou na página de cancelamento de requisição
    Quando eu preencho "Motivo do Cancelamento" com "algum motivo"
    E eu pressiono "Cancelar requisição"
    Então eu devo ver "Requisição cancelada com sucesso!"
    E a requisição deve estar cancelada
    E a requisição não deve estar ligada a nenhuma viagem
    E a viagem não deve atender essa requisição

