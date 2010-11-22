# language: pt

Funcionalidade: Manipular um solicitante

Como um administrador
Eu quero manipular um solicitante
Para que eu possa adicinar, editar e utilizar no sistema

  Esquema do Cenário: Adicionar solicitante
    Dado que eu tenho uma configuração inicial
    Dado que eu sou um usuário administrador logado
    E que eu tenho um centro com nome "P5"
    E que eu estou na página de adição de solicitante
    Quando eu preencho "Nome" com "<nome>"
    E eu preencho "E-mail" com "<e-mail>"
    E eu preencho "Matrícula" com "<matrícula>"
    E eu preencho "Cargo" com "<cargo>"
    E eu seleciono "<centro>" em "Centro"
    E eu pressiono "Salvar"
    Então eu devo ver "<sentença>"

    Exemplos:
    | nome             | e-mail       | matrícula | cargo     | centro | sentença                        |
    | Professor Fulano | prof@uenf.br | 123456    | Professor | P5     | Solicitante criado com sucesso! |
    |                  | prof@uenf.br | 123456    | Professor | P5     | Nome não pode ser vazio         |
    | Professor Fulano | prof@uenf    | 123456    | Professor | P5     | Email não é válido              |
    | Professor Fulano |              | 123456    | Professor | P5     | Email não pode ser vazio        |
    | Professor Fulano | prof@uenf.br |           | Professor | P5     | Matricula não pode ser vazio    |
    | Professor Fulano | prof@uenf.br | 123456    |           | P5     | Cargo não pode ser vazio        |



  Esquema do Cenário: Editar solicitante
    Dado que eu tenho uma configuração inicial
    Dado que eu sou um usuário administrador logado
    E que eu tenha um solicitante com e-mail "prof@uenf.br", matrícula "123456" e centro "P5"
    E que eu estou na página de edição de solicitante
    Quando eu preencho "Nome" com "<nome>"
    E eu preencho "E-mail" com "<e-mail>"
    E eu preencho "Matrícula" com "<matrícula>"
    E eu preencho "Cargo" com "<cargo>"
    E eu seleciono "<centro>" em "Centro"
    E eu pressiono "Salvar"
    Então eu devo ver "<sentença>"

    Exemplos:
    | nome             | e-mail       | matrícula | cargo   | centro | sentença                            |
    | Tecnico Beltrano | prof@uenf.br | 123456    | Tecnico | P5     | Solicitante modificado com sucesso! |

  Esquema do Cenário: Ativar/Desativar um solicitante pela página de edição do solicitante
    Dado que eu tenho uma configuração inicial
    Dado que eu sou um usuário administrador logado
    E que eu tenha um solicitante com e-mail "prof@uenf.br", matrícula "123456" e centro "P5"
    E que o solicitante esteja "<Status do Solicitante>"
    E que eu estou na página de edição do solicitante
    Quando eu seleciono "<Status desejado>" em "Status"
    E eu pressiono "Salvar"
    Então eu devo ver "Status: <Status desejado>"

  Exemplos:
  | Status do Solicitante | Status desejado |
  | Ativo                 | Inativo         |
  | Inativo               | Ativo           |

