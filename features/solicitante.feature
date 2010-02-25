# language: pt

Funcionalidade: Manipular um solicitante

Como um administrador
Eu quero manipular um solicitante
Para que eu possa adicinar, editar e utilizar no sistema

  Esquema do Cenário: Adicionar solicitante
    Dado que eu tenho um prédio com nome "P5"
    E que eu estou na página de adição de solicitante
    Quando eu preencho "Nome" com "<nome>"
    E eu preencho "E-mail" com "<e-mail>"
    E eu preencho "Matrícula" com "<matrícula>"
    E eu preencho "Cargo" com "<cargo>"
    E eu seleciono "<prédio>" em "Prédio"
    E eu seleciono "<andar>" em "Andar"
    E eu pressiono "Criar Solicitante"
    Então eu devo ver "<sentença>"

    Exemplos:

    | nome              | e-mail        | matrícula | cargo     | prédio                | andar                 | sentença                              |
    | Professor Fulano  | prof@uenf.br  | 123456    | Professor | P5                    | Térreo                | Solicitante criado com sucesso!       |
    |                   | prof@uenf.br  | 123456    | Professor | P5                    | Térreo                | Nome não pode ser vazio               |
    | Professor Fulano  | prof@uenf     | 123456    | Professor | P5                    | Térreo                | Email não é válido                    |
    | Professor Fulano  |               | 123456    | Professor | P5                    | Térreo                | Email não pode ser vazio              |
    | Professor Fulano  | prof@uenf.br  |           | Professor | P5                    | Térreo                | Matricula não pode ser vazio          |
    | Professor Fulano  | prof@uenf.br  | 123456    |           | P5                    | Térreo                | Cargo ou funcao não pode ser vazio    |
    | Professor Fulano  | prof@uenf.br  | 123456    | Professor | Selecione um Prédio   | Térreo                | Predio não selecionado                |
    | Professor Fulano  | prof@uenf.br  | 123456    | Professor | P5                    | Selecione um Andar    | Andar não selecionado                 |



  Esquema do Cenário: Editar solicitante
    Dado que eu tenha um solicitante com e-mail "prof@uenf.br", matrícula "123456" e prédio "P5"
    E que eu estou na página de edição de solicitante
    Quando eu preencho "Nome" com "<nome>"
    E eu preencho "E-mail" com "<e-mail>"
    E eu preencho "Matrícula" com "<matrícula>"
    E eu preencho "Cargo" com "<cargo>"
    E eu seleciono "<prédio>" em "Prédio"
    E eu seleciono "<andar>" em "Andar"
    E eu pressiono "Atualizar"
    Então eu devo ver "<sentença>"

    Exemplos:

    | nome              | e-mail        | matrícula | cargo     | prédio                | andar                 | sentença                              |
    | Tecnico Beltrano  | prof@uenf.br  | 123456    | Tecnico   | P5                    | Térreo                | Solicitante modificado com sucesso!   |

