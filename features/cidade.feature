# language: pt

Funcionalidade: Manipular uma Cidade

Como um administrador
Eu quero manipular uma Cidade
Para que eu possa utiliza-la no sistema

  Esquema do Cenário: Adicionar Cidade
    Dado que eu tenho o estado com a sigla "RJ"
    E que eu estou na página de adição de Cidade
    Quando eu preencho "Nome" com "<nome>"
    E eu seleciono "<estado>" em "Estado"
    E eu pressiono "Criar"
    Então eu devo ver "<sentença>"

    Exemplos:
    | nome                  | estado | sentença                   |
    | Campos dos Goytacazes | RJ     | Cidade criada com sucesso! |
    |                       | RJ     | Nome não pode ser vazio    |
    | Campos dos Goytacazes | -      | Estado não pode ser vazio  |


  Cenário: Editar Estado
    Dado que eu tenho uma cidade
    E que eu tenho o estado com a sigla "ES"
    E que eu estou na página de edição da Cidade
    Quando eu preencho "Nome" com "Guarapari"
    E eu seleciono "ES" em "Estado"
    E eu pressiono "Atualizar"
    Então eu devo ver "Cidade modificada com sucesso!"

