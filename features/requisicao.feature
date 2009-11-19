# language: pt

Funcionalidade: Solicitar viagem

  Como um professor
  Eu quero realizar uma requisição de viagem
  Para que eu possa realizar uma viagem

  Esquema do Cenário: Envio de requisição
    Dado que eu tenha uma categoria de veículo "Micro-ônibus - até 32 passageiros"
    E que eu tenha um solicitante com e-mail "ronaldo@corinthians.com" e matricula "01210"
    E que eu estou na página de requisição
    Quando eu preencho "Matrícula" com "<Matrícula>"
    E eu preencho "E-mail" com "<E-mail>"
    E eu preencho "Cargo ou Função" com "<Cargo>"
    E eu preencho "Telefone ou Ramal" com "<Telefone>"
    E eu preencho "Celular" com "<Celular>"
    E eu preencho "Laboratório ou Setor" com "<Laboratório>"
    E eu seleciono "<Prédio>" em "Prédio"
    E eu seleciono "<Andar>" em "Andar"
    E eu preencho "Sala" com "<Sala>"
    E eu escolho requisição de "Ida"
    E eu preencho "Data de Reserva de Ida" com uma data de dois dias seguintes a partir de hoje
    E eu seleciono "<Categoria de veículo>" em "Categoria de veículo"
    E eu seleciono "<Objetivo>" em "Objetivo da Reserva"
    E eu preencho "Outros" com "<Outros>"
    E eu preencho "Nome(s) e telefone do(s) passageiro(s):" com "<Nome_passageiros>"
    E eu preencho "Roteiro da agenda:" com "<Roteiro>"
    E eu preencho "Observação" com "<Observação>"
    E <Termo>
    E <Ação>
    Então <Sentença>


    Exemplos:(Requisição enviada com sucesso)

    | Matrícula | E-mail                     | Cargo     | Telefone  | Celular   | Laboratório   | Prédio                | Andar                 | Sala  | Categoria de veículo              | Objetivo              | Outros    | Nome_passageiros          | Roteiro           | Observação    | Termo                 | Ação                  | Sentença                                      |
    | 01210     | ronaldo@corinthians.com    | Aluno     | 2739-1689 | 9997-3421 | LCMAT         | P5                    | 1º andar              | 121   | Micro-ônibus - até 32 passageiros | Aula de Campo         |           | Zina, Ronaldo e Alfinete  | Ir ao Pacaembu    |               | eu marco "Termos"     | eu pressiono "Enviar" | eu devo ver "Requisição enviada com sucesso!" |
    | 01210     | ronaldo@corinthians.com    | Aluno     | 2739-1689 | 9997-3421 | LCMAT         | P5                    | 1º andar              | 121   | Micro-ônibus - até 32 passageiros | Outros                | Bla       | Zina, Ronaldo e Alfinete  | Ir ao Pacaembu    |               | eu marco "Termos"     | eu pressiono "Enviar" | eu devo ver "Requisição enviada com sucesso!" |


    Exemplos:(Campos vazios)

    | Matrícula | E-mail                    | Cargo     | Telefone  | Celular   | Laboratório   | Prédio                | Andar                 | Sala  | Categoria de veículo              | Objetivo              | Outros    | Nome_passageiros          | Roteiro           | Observação    | Termo                 | Ação                  | Sentença                                                      |
    |           | ronaldo@corinthians.com   | Aluno     | 2739-1689 | 9997-3421 | LCMAT         | P5                    | 1º andar              | 121   | Micro-ônibus - até 32 passageiros | Aula de Campo         |           | Zina, Ronaldo e Alfinete  | Ir ao Pacaembu    |               | eu marco "Termos"     | eu pressiono "Enviar" | eu devo ver "Solicitante não existe"                          |
    | 01210     |                           | Aluno     | 2739-1689 | 9997-3421 | LCMAT         | P5                    | 1º andar              | 121   | Micro-ônibus - até 32 passageiros | Aula de Campo         |           | Zina, Ronaldo e Alfinete  | Ir ao Pacaembu    |               | eu marco "Termos"     | eu pressiono "Enviar" | eu devo ver "Solicitante não existe"                          |
    | 01210     | ronaldo@corinthians.com   |           | 2739-1689 | 9997-3421 | LCMAT         | P5                    | 1º andar              | 121   | Micro-ônibus - até 32 passageiros | Aula de Campo         |           | Zina, Ronaldo e Alfinete  | Ir ao Pacaembu    |               | eu marco "Termos"     | eu pressiono "Enviar" | eu devo ver "Cargo ou funcao não pode ser vazio"              |
    | 01210     | ronaldo@corinthians.com   | Aluno     |           | 9997-3421 | LCMAT         | P5                    | 1º andar              | 121   | Micro-ônibus - até 32 passageiros | Aula de Campo         |           | Zina, Ronaldo e Alfinete  | Ir ao Pacaembu    |               | eu marco "Termos"     | eu pressiono "Enviar" | eu devo ver "Telefone ou ramal não pode ser vazio"            |
    | 01210     | ronaldo@corinthians.com   | Aluno     | 2739-1689 | 9997-3421 |               | P5                    | 1º andar              | 121   | Micro-ônibus - até 32 passageiros | Aula de Campo         |           | Zina, Ronaldo e Alfinete  | Ir ao Pacaembu    |               | eu marco "Termos"     | eu pressiono "Enviar" | eu devo ver "Laboratorio ou setor não pode ser vazio"         |
    | 01210     | ronaldo@corinthians.com   | Aluno     | 2739-1689 | 9997-3421 | LCMAT         | Selecione um Prédio   | 1º andar              | 121   | Micro-ônibus - até 32 passageiros | Aula de Campo         |           | Zina, Ronaldo e Alfinete  | Ir ao Pacaembu    |               | eu marco "Termos"     | eu pressiono "Enviar" | eu devo ver "Predio não selecionado"                          |
    | 01210     | ronaldo@corinthians.com   | Aluno     | 2739-1689 | 9997-3421 | LCMAT         | P5                    | Selecione um Andar    | 121   | Micro-ônibus - até 32 passageiros | Aula de Campo         |           | Zina, Ronaldo e Alfinete  | Ir ao Pacaembu    |               | eu marco "Termos"     | eu pressiono "Enviar" | eu devo ver "Andar não selecionado"                           |
    | 01210     | ronaldo@corinthians.com   | Aluno     | 2739-1689 | 9997-3421 | LCMAT         | P5                    | 1º andar              |       | Micro-ônibus - até 32 passageiros | Aula de Campo         |           | Zina, Ronaldo e Alfinete  | Ir ao Pacaembu    |               | eu marco "Termos"     | eu pressiono "Enviar" | eu devo ver "Sala não pode ser vazio"                         |
    | 01210     | ronaldo@corinthians.com   | Aluno     | 2739-1689 | 9997-3421 | LCMAT         | P5                    | 1º andar              | 121   | Selecione uma categoria de veículo| Aula de Campo         |           | Zina, Ronaldo e Alfinete  | Ir ao Pacaembu    |               | eu marco "Termos"     | eu pressiono "Enviar" | eu devo ver "Categoria de veiculo não selecionada"            |
    | 01210     | ronaldo@corinthians.com   | Aluno     | 2739-1689 | 9997-3421 | LCMAT         | P5                    | 1º andar              | 121   | Micro-ônibus - até 32 passageiros | Selecione um Objetivo |           | Zina, Ronaldo e Alfinete  | Ir ao Pacaembu    |               | eu marco "Termos"     | eu pressiono "Enviar" | eu devo ver "Objetivo da reserva não selecionado"             |
    | 01210     | ronaldo@corinthians.com   | Aluno     | 2739-1689 | 9997-3421 | LCMAT         | P5                    | 1º andar              | 121   | Micro-ônibus - até 32 passageiros | Aula de Campo         |           |                           | Ir ao Pacaembu    |               | eu marco "Termos"     | eu pressiono "Enviar" | eu devo ver "Nome telefone passageiros não pode ser vazio"    |
    | 01210     | ronaldo@corinthians.com   | Aluno     | 2739-1689 | 9997-3421 | LCMAT         | P5                    | 1º andar              | 121   | Micro-ônibus - até 32 passageiros | Aula de Campo         |           | Zina, Ronaldo e Alfinete  |                   |               | eu marco "Termos"     | eu pressiono "Enviar" | eu devo ver "Roteiro da agenda não pode ser vazio"            |
    | 01210     | ronaldo@corinthians.com   | Aluno     | 2739-1689 | 9997-3421 | LCMAT         | P5                    | 1º andar              | 121   | Micro-ônibus - até 32 passageiros | Outros                |           | Zina, Ronaldo e Alfinete  | Ir ao Pacaembu    |               | eu marco "Termos"     | eu pressiono "Enviar" | eu devo ver "Outros não pode ser vazio"                       |


    Exemplos:(Campos preenchidos com dados incorretos)

    | Matrícula | E-mail                    | Cargo     | Telefone  | Celular   | Laboratório   | Prédio                | Andar                 | Sala  | Categoria de veículo              | Objetivo              | Outros    | Nome_passageiros          | Roteiro           | Observação    | Termo                                      | Ação                  | Sentença                             |
    | 01210     | ronaldo@corinthians       | Aluno     | 2739-1689 | 9997-3421 | LCMAT         | P5                    | 1º andar              | 121   | Micro-ônibus - até 32 passageiros | Aula de Campo         |           | Zina, Ronaldo e Alfinete  | Ir ao Pacaembu    |               | eu marco "Li e concordo com os termos"     | eu pressiono "Enviar" | eu devo ver "Solicitante não existe" |


  Esquema do Cenário: Envio de requisição com datas inválidas
    Dado que eu tenha uma categoria de veículo "Micro-ônibus - até 32 passageiros"
    E que eu estou na página de requisição
    Quando eu preencho "Matrícula" com "01210"
    E eu preencho "E-mail" com "ronaldo@corinthians.com"
    E eu preencho "Cargo ou Função" com "Aluno"
    E eu preencho "Telefone ou Ramal" com "2739-1689"
    E eu preencho "Laboratório ou Setor" com "LCMAT"
    E eu seleciono "P5" em "Prédio"
    E eu seleciono "1º andar" em "Andar"
    E eu preencho "Sala" com "121"
    E eu preencho "Data de Reserva" com <Data>
    E eu seleciono "Micro-ônibus - até 32 passageiros" em "Categoria de veículo"
    E eu seleciono "Aula de Campo" em "Objetivo da Reserva"
    E eu preencho "Nome(s) e telefone do(s) passageiro(s):" com "Zina, Ronaldo e Alfinete"
    E eu preencho "Roteiro da agenda:" com "Ir ao Pacaembu"
    E eu pressiono "Enviar"
    E eu marco "Li e concordo com os termos"
    Então <Sentença>

    Exemplos:(Datas invalidas)

    | Data                                          | Sentença                                                                          |
    | uma data do ano que vem                       | eu devo ver "Data de reserva deve estar no ano corrente"                          |
    | uma data de um dia seguinte a partir de hoje  | eu devo ver "Data de reserva deve ser no mínimo 2 dias posterior à data atual"    |
    | "50/05/1986"                                  | eu devo ver "Data de reserva inválida"                                            |
    | ""                                            | eu devo ver "Data de reserva não pode ser vazio"                                  |

