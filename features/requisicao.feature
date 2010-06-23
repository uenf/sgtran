# language: pt

Funcionalidade: Solicitar viagem

  Como um professor
  Eu quero realizar uma requisição de viagem
  Para que eu possa realizar uma viagem

  Esquema do Cenário: Envio de requisição
    Dado que eu tenha a categoria de veículo "Micro-ônibus - até 32 passageiros"
    E que eu tenha um objetivo de reserva "Aula de Campo"
    E que eu tenha um objetivo de reserva "Outros"
    E que eu tenha um solicitante com e-mail "ronaldo@corinthians.com", matrícula "01210" e prédio "P5"
    E que eu estou na página de requisição
    Quando eu preencho "Matrícula" com "<Matrícula>"
    E eu preencho "E-mail" com "<E-mail>"
    E eu preencho "Celular" com "<Celular>"
    E eu escolho requisição de "Ida"
    E eu preencho "Data de Reserva de Ida" com uma data de dois dias seguintes a partir de hoje
    E eu seleciono "<Categoria de veículo>" em "Categoria de veículo"
    E eu seleciono "<Objetivo>" em "Objetivo da Reserva"
    E eu preencho "Outros" com "<Outros>"
    E eu preencho "Nome(s) e telefone do(s) passageiro(s):" com "<Nome_passageiros>"
    E eu preencho "Roteiro da agenda (ida):" com "<Roteiro>"
    E eu preencho "Observação" com "<Observação>"
    E <Termo>
    E <Ação>
    Então <Sentença>


    Exemplos:(Requisição enviada com sucesso)

    | Matrícula | E-mail                  | Celular   | Categoria de veículo              | Objetivo      | Outros | Nome_passageiros         | Roteiro        | Observação | Termo                                  | Ação                  | Sentença                                      |
    | 01210     | ronaldo@corinthians.com | 9997-3421 | Micro-ônibus - até 32 passageiros | Aula de Campo |        | Zina, Ronaldo e Alfinete | Ir ao Pacaembu |            | eu marco "Li e concordo com os termos" | eu pressiono "Enviar" | eu devo ver "Requisição enviada com sucesso!" |
    | 01210     | ronaldo@corinthians.com | 9997-3421 | Micro-ônibus - até 32 passageiros | Outros        | Bla    | Zina, Ronaldo e Alfinete | Ir ao Pacaembu |            | eu marco "Li e concordo com os termos" | eu pressiono "Enviar" | eu devo ver "Requisição enviada com sucesso!" |


    Exemplos:(Campos vazios)

    | Matrícula | E-mail                  | Celular   | Categoria de veículo               | Objetivo              | Outros | Nome_passageiros         | Roteiro        | Observação | Termo                                  | Ação                  | Sentença                                                   |
    |           | ronaldo@corinthians.com | 9997-3421 | Micro-ônibus - até 32 passageiros  | Aula de Campo         |        | Zina, Ronaldo e Alfinete | Ir ao Pacaembu |            | eu marco "Li e concordo com os termos" | eu pressiono "Enviar" | eu devo ver "Solicitante não existe"                       |
    | 01210     |                         | 9997-3421 | Micro-ônibus - até 32 passageiros  | Aula de Campo         |        | Zina, Ronaldo e Alfinete | Ir ao Pacaembu |            | eu marco "Li e concordo com os termos" | eu pressiono "Enviar" | eu devo ver "Solicitante não existe"                       |
    | 01210     | ronaldo@corinthians.com | 9997-3421 | Selecione uma categoria de veículo | Aula de Campo         |        | Zina, Ronaldo e Alfinete | Ir ao Pacaembu |            | eu marco "Li e concordo com os termos" | eu pressiono "Enviar" | eu devo ver "Categoria de veiculo não selecionada"         |
    | 01210     | ronaldo@corinthians.com | 9997-3421 | Micro-ônibus - até 32 passageiros  | Selecione um objetivo |        | Zina, Ronaldo e Alfinete | Ir ao Pacaembu |            | eu marco "Li e concordo com os termos" | eu pressiono "Enviar" | eu devo ver "Objetivo de reserva não selecionado"          |
    | 01210     | ronaldo@corinthians.com | 9997-3421 | Micro-ônibus - até 32 passageiros  | Aula de Campo         |        |                          | Ir ao Pacaembu |            | eu marco "Li e concordo com os termos" | eu pressiono "Enviar" | eu devo ver "Nome telefone passageiros não pode ser vazio" |
    | 01210     | ronaldo@corinthians.com | 9997-3421 | Micro-ônibus - até 32 passageiros  | Aula de Campo         |        | Zina, Ronaldo e Alfinete |                |            | eu marco "Li e concordo com os termos" | eu pressiono "Enviar" | eu devo ver "Roteiro da agenda não pode ser vazio"         |
    | 01210     | ronaldo@corinthians.com | 9997-3421 | Micro-ônibus - até 32 passageiros  | Outros                |        | Zina, Ronaldo e Alfinete | Ir ao Pacaembu |            | eu marco "Li e concordo com os termos" | eu pressiono "Enviar" | eu devo ver "Outros não pode ser vazio"                    |
    | 01210     | ronaldo@corinthians.com |           | Micro-ônibus - até 32 passageiros  | Outros                | Bla    | Zina, Ronaldo e Alfinete | Ir ao Pacaembu |            | eu marco "Li e concordo com os termos" | eu pressiono "Enviar" | eu devo ver "Celular não pode ser vazio"                   |

    Exemplos:(Campos preenchidos com dados incorretos)

    | Matrícula | E-mail              | Celular   | Categoria de veículo              | Objetivo      | Outros | Nome_passageiros         | Roteiro        | Observação | Termo                                  | Ação                  | Sentença                             |
    | 01210     | ronaldo@corinthians | 9997-3421 | Micro-ônibus - até 32 passageiros | Aula de Campo |        | Zina, Ronaldo e Alfinete | Ir ao Pacaembu |            | eu marco "Li e concordo com os termos" | eu pressiono "Enviar" | eu devo ver "Solicitante não existe" |


  Esquema do Cenário: Envio de requisição com datas inválidas
    Dado que eu tenha a categoria de veículo "Automóvel até 4 passageiros"
    E que eu tenha um objetivo de reserva "Aula de Campo"
    E que eu tenha um solicitante com e-mail "ronaldo@corinthians.com", matrícula "01210" e prédio "P5"
    E que eu estou na página de requisição
    Quando eu preencho "Matrícula" com "01210"
    E eu preencho "E-mail" com "ronaldo@corinthians.com"
    E eu preencho "Data de Reserva" com <Data>
    E eu seleciono "Automóvel até 4 passageiros" em "Categoria de veículo"
    E eu seleciono "Aula de Campo" em "Objetivo da Reserva"
    E eu preencho "Nome(s) e telefone do(s) passageiro(s):" com "Zina, Ronaldo e Alfinete"
    E eu preencho "Roteiro da agenda (ida):" com "Ir ao Pacaembu"
    E eu marco "Li e concordo com os termos"
    E eu pressiono "Enviar"
    Então <Sentença>

    Exemplos:(Datas invalidas)

    | Data                                             | Sentença                                                                                                                 |
    | uma data do ano que vem                          | eu devo ver "Data de reserva deve estar no ano corrente"                                                                 |
    | uma data de um dia seguinte a partir de hoje     | eu devo ver "Data de reserva deve ser no mínimo 2 dias posterior à data atual"                                           |
    | uma data de "16" dias seguintes a partir de hoje | eu devo ver "Data de reserva deve ser no máximo 15 dias posterior à data atual, para a categoria de veículo selecionada" |
    | "50/05/1986"                                     | eu devo ver "Data de reserva inválida"                                                                                   |
    | ""                                               | eu devo ver "Data de reserva não pode ser vazio"                                                                         |

  Cenário: Mudar a viagem de uma requisição Aceita
    Dado que eu tenho uma requisição com estado "Aceita"
    E que eu tenho uma viagem com o estado "Aguardando"
    E que a requisição esteja ligada à viagem
    E que eu estou na página de detalhes da requisição
    Quando eu clico em "Alterar viagem"
    E eu escolho a viagem existente
    E eu pressiono "Concluir"
    Então eu devo estar na página de visualização da viagem

  Cenário: Mudar a viagem que atende uma requisição sem escolher a viagem
    Dado que eu tenho uma requisição com estado "Aceita"
    E que eu tenho uma viagem com o estado "Aguardando"
    E que a requisição esteja ligada à viagem
    E que eu estou na página de detalhes da requisição
    Quando eu clico em "Alterar viagem"
    E eu pressiono "Concluir"
    Então eu devo ver "Escolha uma viagem."

  Cenário: Enviar uma requisição sem os zeros à esquerda
    Dado que eu tenha a categoria de veículo "Automóvel até 4 passageiros"
    E que eu tenha um objetivo de reserva "Aula de Campo"
    E que eu tenha um solicitante com e-mail "ronaldo@corinthians.com", matrícula "00210" e prédio "P5"
    E que eu estou na página de requisição
    Quando eu preencho "Matrícula" com "210"
    E eu preencho "E-mail" com "ronaldo@corinthians.com"
    E eu preencho "Celular" com "9999-9999"
    E eu preencho "Data de Reserva" com uma data de dois dias seguintes a partir de hoje
    E eu seleciono "Automóvel até 4 passageiros" em "Categoria de veículo"
    E eu seleciono "Aula de Campo" em "Objetivo da Reserva"
    E eu preencho "Nome(s) e telefone do(s) passageiro(s):" com "Zina, Ronaldo e Alfinete"
    E eu preencho "Roteiro da agenda (ida):" com "Ir ao Pacaembu"
    E eu marco "Li e concordo com os termos"
    E eu pressiono "Enviar"
    Então eu devo ver "Requisição enviada com sucesso!"

  Esquema do Cenário: Deve aceitar apenas solicitantes ativos
    Dado que eu tenha a categoria de veículo "Automóvel até 4 passageiros"
    E que eu tenha um objetivo de reserva "Aula de Campo"
    E que eu tenha um solicitante com e-mail "ronaldo@corinthians.com", matrícula "00210" e prédio "P5"
    E que o solicitante esteja "<Estado>"
    E que eu estou na página de requisição
    Quando eu preencho "Matrícula" com "210"
    E eu preencho "E-mail" com "ronaldo@corinthians.com"
    E eu preencho "Celular" com "9999-9999"
    E eu preencho "Data de Reserva" com uma data de dois dias seguintes a partir de hoje
    E eu seleciono "Automóvel até 4 passageiros" em "Categoria de veículo"
    E eu seleciono "Aula de Campo" em "Objetivo da Reserva"
    E eu preencho "Nome(s) e telefone do(s) passageiro(s):" com "Zina, Ronaldo e Alfinete"
    E eu preencho "Roteiro da agenda (ida):" com "Ir ao Pacaembu"
    E eu marco "Li e concordo com os termos"
    E eu pressiono "Enviar"
    Então eu devo ver "<Resposta>"

  Exemplos:
  | Estado  | Resposta                        |
  | Ativo   | Requisição enviada com sucesso! |
  | Inativo | Solicitante não existe          |

