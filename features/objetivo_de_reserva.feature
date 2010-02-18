# language: pt

Funcionalidade: Manipular um objetivo de reserva

Como um administrador
Eu quero manipular um objetivo de reserva
Para que eu possa adicinar, editar e utilizar no sistema

  Esquema do Cenário: Adicionar objetivo de reserva
    Dado que eu estou na página de adição de objetivo de reserva
    Quando eu preencho "Texto" com "<texto>"
    E eu pressiono "Criar"
    Então eu devo ver "<sentença>"

    Exemplos:

    | texto         | sentença                                 |
    | Aula de Campo | Objetivo de reserva criado com sucesso!  |
    |               | Texto não pode ser vazio                 |


  Esquema do Cenário: Editar objetivo de reserva
    Dado que eu tenha um objetivo de reserva "Aula de Campo"
    E que eu estou na página de edição de objetivo de reserva
    Quando eu preencho "Texto" com "<texto>"
    E eu pressiono "Modificar"
    Então eu devo ver "<sentença>"

    Exemplos:

    | texto             | sentença                                     |
    | Aula de Campo 2   | Objetivo de reserva modificado com sucesso!  |
    |                   | Texto não pode ser vazio                     |

