# language: pt

Funcionalidade: Manipular um prédio

Como um administrador
Eu quero manipular um prédio
Para que eu possa adicinar, editar e utilizar no sistema

  Esquema do Cenário: Adicionar prédio
    Dado que eu estou na página de adição de prédio
    Quando eu preencho "Nome" com "<nome>"
    E eu pressiono "Criar"
    Então eu devo ver "<sentença>"

    Exemplos:

    | nome  | sentença                      |
    | P5    | Prédio criado com sucesso!    |
    |       | Nome não pode ser vazio       |


  Esquema do Cenário: Editar prédio
    Dado que eu tenho um prédio
    E que eu estou na página de edição de prédio
    Quando eu preencho "Nome" com "<nome>"
    E eu pressiono "Atualizar"
    Então eu devo ver "<sentença>"

    Exemplos:

    | nome          | sentença                          |
    | Outro nome    | Prédio modificado com sucesso!    |

