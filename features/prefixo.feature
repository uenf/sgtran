# language: pt

Funcionalidade: Manipular um prefixo

Como um administrador
Eu quero manipular um prefixo
Para que eu possa adicinar, editar e utilizar no sistema

  Esquema do Cenário: Adicionar prefixo
    Dado que eu estou na página de adição de prefixo
    Quando eu preencho "Nome:" com "<nome>"
    E eu seleciono "Ativo" em "Status"
    E eu pressiono "Criar Prefixo"
    Então eu devo ver "<sentença>"
    E <expectativa>

    Exemplos:

    | nome      | sentença                      | expectativa                     |
    | Locado    | Prefixo criado com sucesso!   | eu devo ter um prefixo "Ativo"  |
    |           | Nome não pode ser vazio       | eu não devo ter um prefixo      |


  Esquema do Cenário: Editar prefixo
    Dado que eu tenho um prefixo
    E que eu estou na página de edição do prefixo
    Quando eu preencho "Nome" com "<nome>"
    E eu seleciono "Inativo" em "Status"
    E eu pressiono "Atualizar"
    Então eu devo ver "<sentença>"
    E eu devo ter um prefixo "Inativo"

    Exemplos:

    | nome          | sentença                           |
    | Outro nome    | Prefixo modificado com sucesso!    |


  Esquema do Cenário: Ativar/Desativar um prefixo pela página de edição
    Dado que eu tenho um prefixo
    E que o prefixo esteja "<Estado do Prefixo>"
    E que eu estou na página de edição do prefixo
    Quando eu seleciono "<Estado desejado>" em "Status"
    E eu pressiono "Atualizar"
    Então eu devo ver "Estado: <Estado desejado>"
    E eu devo ter um prefixo "<Estado desejado>"

    Exemplos:
    | Estado do Prefixo   | Estado desejado |
    | Ativo               | Inativo         |
    | Inativo             | Ativo           |


  @1
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
    Dado que eu tenho o prefixo "Projetos"
    E que o prefixo esteja "<Estado>"
    E que eu tenha um veículo da categoria "4 passageiros", modelo "Uno" e placa "SDF-8457"
    E que eu estou na página de edição do veículo
    Então eu <Ação>

    Exemplos:
    | Estado      | Ação                  |
    | Ativo       | devo ver "Projetos"     |
    | Inativo     | não devo ver "Projetos" |

