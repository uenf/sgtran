# language: pt

Funcionalidade: Manipular um motorista

Como um administrador
Eu quero manipular um motorista
Para que eu possa adicinar, editar e utilizar no sistema

  Esquema do Cenário: Adicionar motorista
    Dado que eu estou na página de adição de motorista
    Quando eu preencho "Matrícula" com "<matricula>"
    E eu preencho "Nome" com "<nome>"
    E eu preencho "Telefone" com "<telefone>"
    E eu preencho "Habilitação" com "<habilitacao>"
    E eu preencho "Vencimento da habilitação" com "<vencimento_habilitacao>"
    E eu pressiono "Criar Motorista"
    Então eu devo ver "<sentença>"

    Exemplos:

    | matricula | nome          | telefone          | habilitacao | vencimento_habilitacao  | sentença                                  |
    | 100000    | fulano de tal | (00) 0000-0000    | 03811585669 | 19/05/2010              | Motorista criado com sucesso!             |
    |           | fulano de tal | (00) 0000-0000    | 03811585669 | 19/05/2010              | Matricula não pode ser vazio              |
    | 100000    |               | (00) 0000-0000    | 03811585669 | 19/05/2010              | Nome não pode ser vazio                   |
    | 100000    | fulano de tal |                   | 03811585669 | 19/05/2010              | Telefone do motorista não pode ser vazio  |


  Esquema do Cenário: Editar motorista
    Dado que eu tenha "Gustavo Santos" em Motorista
    E que eu estou na página de edição de motorista
    Quando eu preencho "Matrícula" com "<matricula>"
    E eu preencho "Nome" com "<nome>"
    E eu preencho "Telefone" com "<telefone>"
    E eu preencho "Habilitação" com "<habilitacao>"
    E eu preencho "Vencimento da habilitação" com "<vencimento_habilitacao>"
    E eu pressiono "Atualizar"
    Então eu devo ver "<sentença>"

    Exemplos:

    | matricula | nome          | telefone          | habilitacao | vencimento_habilitacao  | sentença                                      |
    | 100000    | fulano de tal | (00) 0000-0000    | 03811585669 | 19/05/2010              | Motorista modificado com sucesso!             |
    |           | fulano de tal | (00) 0000-0000    | 03811585669 | 19/05/2010              | Matricula não pode ser vazio                  |
    | 100000    |               | (00) 0000-0000    | 03811585669 | 19/05/2010              | Nome não pode ser vazio                       |
    | 100000    | fulano de tal |                   | 03811585669 | 19/05/2010              | Telefone do motorista não pode ser vazio      |

