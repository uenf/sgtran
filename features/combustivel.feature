# language: pt

Funcionalidade: Adicionar um novo combustível

Como um administrador
Eu quero adicionar um novo combustível
Para que eu possa utiliza-lo no sistema

  Esquema do Cenário: Adicionar combustível
    Dado que eu estou na página de adição de combustível
    Quando eu preencho "Nome" com "<nome>"
    E eu pressiono "Criar"
    Então eu devo ver "<sentença>"

    Exemplos:
    | nome   | sentença                        |
    | Álcool | Combustível criado com sucesso! |
    |        | Nome não pode ser vazio         |


  Esquema do Cenário: Editar combustível
    Dado que eu tenho o combustível "Álcool"
    E que eu estou na página de edição de combustível
    Quando eu preencho "Nome" com "<nome>"
    E eu pressiono "Atualizar"
    Então eu devo ver "<sentença>"

    Exemplos:
    | nome               | sentença                            |
    | Gasolina Aditivada | Combustível modificado com sucesso! |
    |                    | Nome não pode ser vazio             |

