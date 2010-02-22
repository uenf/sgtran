# language: pt

Funcionalidade: Manipular um motivo

Como um administrador
Eu quero manipular um motivo
Para que eu possa adicinar, editar e utilizar no sistema

  Esquema do Cenário: Adicionar motivo
    Dado que eu estou na página de adição de motivo
    Quando eu preencho "Descrição" com "<descricao>"
    E eu pressiono "Criar"
    Então eu devo ver "<sentença>"

    Exemplos:

    | descricao                 | sentença                      |
    | Não há carro disponível   | Motivo criado com sucesso!    |
    |                           | Descricao não pode ser vazio  |


  Esquema do Cenário: Editar motivo
    Dado que eu tenho um motivo com descrição "Não há carro disponível"
    E que eu estou na página de edição de motivo
    Quando eu preencho "Descrição" com "<descricao>"
    E eu pressiono "Atualizar"
    Então eu devo ver "<sentença>"

    Exemplos:

    | descricao                 | sentença                          |
    | Não há carro disponível 2 | Motivo modificado com sucesso!    |
    |                           | Descricao não pode ser vazio      |
