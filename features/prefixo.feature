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


  Esquema do Cenário: Mostrar na adição dos veículos apenas os prefixos ativos
    Dado que eu tenho o prefixo "Locado"
    E que o prefixo esteja "<Estado>"
    E que eu estou na página de adição de veículo
    Então eu <Ação>

    Exemplos:
    | Estado      | Ação                  |
    | Ativo       | devo ver "Locado"     |
    | Inativo     | não devo ver "Locado" |


  Esquema do Cenário: Mostrar na edição dos veículos apenas os prefixos ativos
    Dado que eu tenho o prefixo "Locado"
    E que o prefixo esteja "<Estado>"
    E que eu tenha um veículo da categoria "4 passageiros", modelo "Uno" e placa "SDF-8457"
    E que eu estou na página de edição do veículo
    Então eu <Ação>

    Exemplos:
    | Estado      | Ação                  |
    | Ativo       | devo ver "Locado"     |
    | Inativo     | não devo ver "Locado" |

