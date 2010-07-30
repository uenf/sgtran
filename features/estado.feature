# language: pt

Funcionalidade: Manipular um Estado

Como um administrador
Eu quero manipular um Estado
Para que eu possa utiliza-lo no sistema

  Esquema do Cenário: Adicionar Estado
    Dado que eu estou na página de adição de Estado
    Quando eu preencho "Nome" com "<nome>"
    E eu preencho "Sigla" com "<sigla>"
    E eu pressiono "Criar"
    Então eu devo ver "<sentença>"

    Exemplos:
    | nome           | sigla | sentença                   |
    | Rio de Janeiro | RJ    | Estado criado com sucesso! |
    |                | RJ    | Nome não pode ser vazio    |
    | Rio de Janeiro |       | Sigla não pode ser vazio   |


  Cenário: Editar Estado
    Dado que eu tenho o Estado "Rio de Janeiro"
    E que eu estou na página de edição do Estado
    Quando eu preencho "Nome" com "São Paulo"
    E eu pressiono "Atualizar"
    Então eu devo ver "Estado modificado com sucesso!"

