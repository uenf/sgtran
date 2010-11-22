# language: pt

Funcionalidade: Manipular um motorista

Como um administrador
Eu quero manipular um motorista
Para que eu possa adicionar, editar e utilizar no sistema

  Esquema do Cenário: Adicionar motorista
    Dado que eu tenho uma configuração inicial
    Dado que eu sou um usuário administrador logado
    E que eu estou na página de adição de motorista
    Quando eu preencho "Matrícula" com "<matricula>"
    E eu preencho "Nome" com "<nome>"
    E eu preencho "Telefone" com "<telefone>"
    E eu preencho "Habilitação" com "<habilitacao>"
    E eu preencho "Vencimento da habilitação" com "<vencimento_habilitacao>"
    E eu pressiono "Salvar"
    Então eu devo ver "<sentença>"

    Exemplos:

    | matricula | nome            | telefone       | habilitacao | vencimento_habilitacao | sentença                      |
    | 100000    | Gustavo Ribeiro | (00) 0000-0000 | 03811585669 | 19/05/2010             | Motorista criado com sucesso! |
    |           | Gustavo Ribeiro | (00) 0000-0000 | 03811585669 | 19/05/2010             | Matricula não pode ser vazio  |
    | 100000    |                 | (00) 0000-0000 | 03811585669 | 19/05/2010             | Nome não pode ser vazio       |
    | 100000    | Gustavo Ribeiro |                | 03811585669 | 19/05/2010             | Telefone não pode ser vazio   |


  Esquema do Cenário: Editar motorista
    Dado que eu tenho uma configuração inicial
    Dado que eu sou um usuário administrador logado
    E que eu tenho um motorista com nome "Gustavo Santos"
    E que eu estou na página de edição de motorista
    Quando eu preencho "Matrícula" com "<matricula>"
    E eu preencho "Nome" com "<nome>"
    E eu preencho "Telefone" com "<telefone>"
    E eu preencho "Habilitação" com "<habilitacao>"
    E eu preencho "Vencimento da habilitação" com "<vencimento_habilitacao>"
    E eu pressiono "Salvar"
    Então eu devo ver "<sentença>"

    Exemplos:

    | matricula | nome            | telefone       | habilitacao | vencimento_habilitacao | sentença                          |
    | 100000    | Gustavo Ribeiro | (00) 0000-0000 | 03811585669 | 19/05/2010             | Motorista modificado com sucesso! |
    |           | Gustavo Ribeiro | (00) 0000-0000 | 03811585669 | 19/05/2010             | Matricula não pode ser vazio      |
    | 100000    |                 | (00) 0000-0000 | 03811585669 | 19/05/2010             | Nome não pode ser vazio           |
    | 100000    | Gustavo Ribeiro |                | 03811585669 | 19/05/2010             | Telefone não pode ser vazio       |


  Esquema do Cenário: Ativar/Desativar um motorista pela página de edição
    Dado que eu tenho uma configuração inicial
    Dado que eu sou um usuário administrador logado
    E que eu tenho um motorista com nome "Gustavo Santos"
    E que o motorista esteja "<Status do Motorista>"
    E que eu estou na página de edição de motorista
    Quando eu seleciono "<Status desejado>" em "Status"
    E eu pressiono "Salvar"
    Então eu devo ver "Status: <Status desejado>"

  Exemplos:
  | Status do Solicitante | Status desejado |
  | Ativo                 | Inativo         |
  | Inativo               | Ativo           |

