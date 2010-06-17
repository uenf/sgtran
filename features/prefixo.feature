# language: pt

Funcionalidade: Manipular um prefixo

Como um administrador
Eu quero manipular um prefixo
Para que eu possa adicinar, editar e utilizar no sistema

  Esquema do Cenário: Adicionar prefixo
    Dado que eu estou na página de adição de prefixo
    Quando eu preencho "Nome:" com "<nome>"
    E eu pressiono "Criar Prefixo"
    Então eu devo ver "<sentença>"

    Exemplos:

    | nome      | sentença                      |
    | Locado    | Prefixo criado com sucesso!   |
    |           | Nome não pode ser vazio       |


  Esquema do Cenário: Editar prefixo
    Dado que eu tenho um prefixo
    E que eu estou na página de edição do prefixo
    Quando eu preencho "Nome" com "<nome>"
    E eu pressiono "Atualizar"
    Então eu devo ver "<sentença>"

    Exemplos:

    | nome          | sentença                           |
    | Outro nome    | Prefixo modificado com sucesso!    |


  Esquema do Cenário: Ativar/Desativar um prefixo pela página de edição
    Dado que eu tenho um prefixo
    E que o prefixo esteja "<Estado do Prefixo>"
    E que eu estou na página de edição do prefixo
    Quando eu seleciono "<Estado desejado>" em "Estado"
    E eu pressiono "Atualizar"
    Então eu devo ver "Estado: <Estado desejado>"

  Exemplos:
  | Estado do Prefixo   | Estado desejado |
  | Ativo               | Inativo         |
  | Inativo             | Ativo           |

#  Esquema do Cenário: Mostrar na requisição apenas os prefixos ativos
#    Dado que eu tenho um prefixo com nome "P5"
#    E que o prefixo esteja "<Estado>"
#    E que eu estou na página de adição de solicitante
#    Então eu <Visão>
#
#  Exemplos:
#  | Estado      | Visão             |
#  | Ativo       | devo ver "P5"     |
#  | Inativo     | não devo ver "P5" |

