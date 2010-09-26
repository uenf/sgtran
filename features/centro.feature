# language: pt

Funcionalidade: Manipular um prédio

Como um administrador
Eu quero manipular um prédio
Para que eu possa adicinar, editar e utilizar no sistema

  Esquema do Cenário: Adicionar prédio
    Dado que eu estou na página de adição de prédio
    Quando eu preencho "Nome" com "<nome>"
    E eu pressiono "Salvar"
    Então eu devo ver "<sentença>"

    Exemplos:

    | nome | sentença                   |
    | P5   | Centro criado com sucesso! |
    |      | Nome não pode ser vazio    |


  Esquema do Cenário: Editar prédio
    Dado que eu tenho um prédio
    E que eu estou na página de edição de prédio
    Quando eu preencho "Nome" com "<nome>"
    E eu pressiono "Salvar"
    Então eu devo ver "<sentença>"

    Exemplos:

    | nome       | sentença                       |
    | Outro nome | Centro modificado com sucesso! |

  Esquema do Cenário: Ativar/Desativar um centro pela página de edição
    Dado que eu tenho um prédio
    E que o prédio esteja "<Status do Objetivo>"
    E que eu estou na página de edição do prédio
    Quando eu seleciono "<Status desejado>" em "Status"
    E eu pressiono "Salvar"
    Então eu devo ver "Status: <Status desejado>"

  Exemplos:
  | Status do Objetivo | Status desejado |
  | Ativo              | Inativo         |
  | Inativo            | Ativo           |

  Esquema do Cenário: Mostrar na requisição apenas os centros ativos
    Dado que eu tenho um prédio com nome "P5"
    E que o prédio esteja "<Status>"
    E que eu estou na página de adição de solicitante
    Então eu <Visão>

  Exemplos:
  | Status  | Visão             |
  | Ativo   | devo ver "P5"     |
  | Inativo | não devo ver "P5" |

