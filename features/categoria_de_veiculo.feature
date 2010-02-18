# language: pt

Funcionalidade: Adicionar uma categoria de veículo

Como um administrador
Eu quero adicionar uma nova categoria de veículo
Para que eu possa utiliza-la no sistema

  Esquema do Cenário: Adicionar categoria de veículo
    Dado que eu estou na página de adição de categoria de veículo
    Quando eu preencho "Nome" com "<nome>"
    E eu pressiono "Criar Categoria de veículo"
    Então eu devo ver "<sentença>"

    Exemplos:

    | nome                          | sentença                                 |
    | Automóvel até 4 passageiros   | Categoria de veículo criada com sucesso! |
    |                               | Nome não pode ser vazio                  |


  Esquema do Cenário: Editar categoria de veículo
    Dado que eu tenha uma categoria de veículo "Automóvel até 4 passageiros"
    E que eu estou na página de edição de categoria de veículo
    Quando eu preencho "Nome" com "<nome>"
    E eu pressiono "Atualizar"
    Então eu devo ver "<sentença>"

    Exemplos:

    | nome                          | sentença                                      |
    | Automóvel até 6 passageiros   | Categoria de veículo modificada com sucesso!  |
    |                               | Nome não pode ser vazio                       |

