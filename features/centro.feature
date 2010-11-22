# language: pt

Funcionalidade: Manipular um centro

Como um administrador
Eu quero manipular um centro
Para que eu possa adicinar, editar e utilizar no sistema

  Esquema do Cenário: Adicionar centro
    Dado que eu tenho uma configuração inicial
    Dado que eu sou um usuário administrador logado
    E que eu estou na página de adição de centro
    Quando eu preencho "Nome" com "<nome>"
    E eu pressiono "Salvar"
    Então eu devo ver "<sentença>"

    Exemplos:

    | nome | sentença                   |
    | P5   | Centro criado com sucesso! |
    |      | Nome não pode ser vazio    |


  Esquema do Cenário: Editar centro
    Dado que eu tenho uma configuração inicial
    Dado que eu sou um usuário administrador logado
    E que eu tenho um centro
    E que eu estou na página de edição de centro
    Quando eu preencho "Nome" com "<nome>"
    E eu pressiono "Salvar"
    Então eu devo ver "<sentença>"

    Exemplos:

    | nome       | sentença                       |
    | Outro nome | Centro modificado com sucesso! |

  Esquema do Cenário: Ativar/Desativar um centro pela página de edição
    Dado que eu tenho uma configuração inicial
    Dado que eu sou um usuário administrador logado
    E que eu tenho um centro
    E que o centro esteja "<Status do Objetivo>"
    E que eu estou na página de edição do centro
    Quando eu seleciono "<Status desejado>" em "Status"
    E eu pressiono "Salvar"
    Então eu devo ver "Status: <Status desejado>"

  Exemplos:
  | Status do Objetivo | Status desejado |
  | Ativo              | Inativo         |
  | Inativo            | Ativo           |

  Esquema do Cenário: Mostrar na requisição apenas os centros ativos
    Dado que eu tenho uma configuração inicial
    Dado que eu sou um usuário administrador logado
    E que eu tenho um centro com nome "P5"
    E que o centro esteja "<Status>"
    E que eu estou na página de adição de solicitante
    Então eu <Visão>

  Exemplos:
  | Status  | Visão             |
  | Ativo   | devo ver "P5"     |
  | Inativo | não devo ver "P5" |

