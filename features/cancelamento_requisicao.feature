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
    E <Ação>
    Então <Sentença>


    Exemplos:(Requisição cancelada com sucesso)

    | Motivo       | Ação                               | Sentença                                                        |
    | Estou doente | eu pressiono "Cancelar requisição" | eu devo ver "Requisição cancelada com sucesso!" |
    | Faltou verba | eu pressiono "Cancelar requisição" | eu devo ver "Requisição cancelada com sucesso!" |

    Exemplos:(Campos vazios)

    | Motivo       | Ação                               | Sentença                                |
    |              | eu pressiono "Cancelar requisição" | eu devo ver "Motivo nao pode ser vazio" |


  Cenário: Cancelamento de requisição com dados incorretos
    Dado que eu tenho uma requisição do solicitante com matricula "01210" e com o nome "Carlos"
    Quando eu vou para página de cancelamento de requisição com id 1 e chave de segurança 123abc
    Então eu devo ver "Solicitação de reserva de veículos"

  Cenário: Cancelamento de requisição que já foi cancelada
    Dado que eu tenho uma requisição com estado cancelado por motivo de falta de verba
    Quando eu vou para página de cancelamento de requisição
    Então eu devo ver "Esta requisição já foi cancelada."

