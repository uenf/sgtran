# language: pt

Funcionalidade: Manipular um motivo

  Como um administrador
  Eu quero manipular um motivo
  Para que eu possa adicinar, editar e utilizar no sistema

    Esquema do Cenário: Adicionar motivo
      Dado que eu estou na página de adição de motivo
      Quando eu preencho "Descrição" com "<descricao>"
      E eu pressiono "Salvar"
      Então eu devo ver "<sentença>"

      Exemplos:

      | descricao               | sentença                     |
      | Não há carro disponível | Motivo criado com sucesso!   |
      |                         | Descricao não pode ser vazio |


    Esquema do Cenário: Editar motivo
      Dado que eu tenho um motivo com descrição "Não há carro disponível"
      E que eu estou na página de edição de motivo
      Quando eu preencho "Descrição" com "<descricao>"
      E eu pressiono "Salvar"
      Então eu devo ver "<sentença>"

      Exemplos:

      | descricao                 | sentença                       |
      | Não há carro disponível 2 | Motivo modificado com sucesso! |
      |                           | Descricao não pode ser vazio   |

    Esquema do Cenário: Ativar/Desativar um motivo pela página de edição
      Dado que eu tenho um motivo com descrição "Algum motivo"
      E que o motivo esteja "<Estado do Motivo>"
      E que eu estou na página de edição do motivo
      Quando eu seleciono "<Status desejado>" em "Status"
      E eu pressiono "Salvar"
      Então eu devo ver "Status: <Status desejado>"

    Exemplos:
    | Status do Motivo | Status desejado |
    | Ativo            | Inativo         |
    | Inativo          | Ativo           |

    Esquema do Cenário: Mostrar apenas motivos ativos ao rejeitar a requisição
      Dado que eu tenho uma requisição com estado "Em Espera" e id "25"
      E que eu tenho um motivo com descrição "Falta de carros"
      E que o motivo esteja "<Status>"
      E que eu estou na página de rejeitar uma requisição
      Então eu <Visão>

    Exemplos:
    | Status  | Visão                          |
    | Ativo   | devo ver "Falta de carros"     |
    | Inativo | não devo ver "Falta de carros" |

    Esquema do Cenário: Mostrar apenas motivos ativos ao cancelar a requisição pelo sistema
      Dado que eu tenho uma requisição com estado "Aceita" e id "25"
      E que eu tenho um motivo com descrição "Falta de verba"
      E que o motivo esteja "<Status>"
      E que eu tenho uma viagem com o estado "Aguardando"
      E que a requisição esteja ligada à viagem
      E que eu estou na página de cancelamento pelo sistema da requisição
      Então eu <Visão>

    Exemplos:
    | Status  | Visão                         |
    | Ativo   | devo ver "Falta de verba"     |
    | Inativo | não devo ver "Falta de verba" |

