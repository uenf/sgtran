# language: pt

Funcionalidade: Solicitar viagem

  Como um professor
  Eu quero realizar uma requisição de viagem
  Para que eu possa realizar uma viagem

  Esquema do Cenário: Envio de requisição
    Dado que eu tenho uma configuração inicial
    Dado que eu não estou logado
    E que eu tenha a categoria de veículo "Micro-ônibus - até 32 passageiros"
    E que eu tenha um objetivo de reserva "Aula de Campo"
    E que eu tenha um objetivo de reserva "Outros"
    E que eu tenha um solicitante com e-mail "ronaldo@corinthians.com", matrícula "01210" e centro "P5"
    E que eu estou na página de requisição
    Quando eu preencho "Matrícula" com "<Matrícula>"
    E eu preencho "E-mail" com "<E-mail>"
    E eu preencho "Celular" com "<Celular>"
    E eu preencho "Data" com uma data de dois dias seguintes a partir de hoje
    E eu seleciono "<Categoria de veículo>" em "Veículo"
    E eu seleciono "<Objetivo>" em "Objetivo"
    E eu preencho "Passageiros:" com "<Nome_passageiros>"
    E eu preencho "Roteiro:" com "<Roteiro>"
    E eu preencho "Observações" com "<Observação>"
    E <Termo>
    E <Ação>
    Então <Sentença>


    Exemplos:(Requisição enviada com sucesso)

    | Matrícula | E-mail                  | Celular   | Categoria de veículo              | Objetivo      | Nome_passageiros         | Roteiro        | Observação | Termo                                  | Ação                              | Sentença                                      |
    | 01210     | ronaldo@corinthians.com | 9997-3421 | Micro-ônibus - até 32 passageiros | Aula de Campo | Zina, Ronaldo e Alfinete | Ir ao Pacaembu |            | eu marco "Li e concordo com os termos" | eu pressiono "Enviar requisição" | eu devo ver "Requisição enviada com sucesso!" |
    | 01210     | ronaldo@corinthians.com | 9997-3421 | Micro-ônibus - até 32 passageiros | Outros        | Zina, Ronaldo e Alfinete | Ir ao Pacaembu |            | eu marco "Li e concordo com os termos" | eu pressiono "Enviar requisição" | eu devo ver "Requisição enviada com sucesso!" |


    Exemplos:(Campos vazios)

    | Matrícula | E-mail                  | Celular   | Categoria de veículo               | Objetivo              | Nome_passageiros         | Roteiro        | Observação | Termo                                  | Ação                              | Sentença                                                   |
    |           | ronaldo@corinthians.com | 9997-3421 | Micro-ônibus - até 32 passageiros  | Aula de Campo         | Zina, Ronaldo e Alfinete | Ir ao Pacaembu |            | eu marco "Li e concordo com os termos" | eu pressiono "Enviar requisição" | eu devo ver "Solicitante não existe"                       |
    | 01210     |                         | 9997-3421 | Micro-ônibus - até 32 passageiros  | Aula de Campo         | Zina, Ronaldo e Alfinete | Ir ao Pacaembu |            | eu marco "Li e concordo com os termos" | eu pressiono "Enviar requisição" | eu devo ver "Solicitante não existe"                       |
    | 01210     | ronaldo@corinthians.com | 9997-3421 | Selecione uma categoria de veículo | Aula de Campo         | Zina, Ronaldo e Alfinete | Ir ao Pacaembu |            | eu marco "Li e concordo com os termos" | eu pressiono "Enviar requisição" | eu devo ver "Categoria de veiculo não selecionada"         |
    | 01210     | ronaldo@corinthians.com | 9997-3421 | Micro-ônibus - até 32 passageiros  | Selecione um objetivo | Zina, Ronaldo e Alfinete | Ir ao Pacaembu |            | eu marco "Li e concordo com os termos" | eu pressiono "Enviar requisição" | eu devo ver "Objetivo de reserva não selecionado"          |
    | 01210     | ronaldo@corinthians.com | 9997-3421 | Micro-ônibus - até 32 passageiros  | Aula de Campo         |                          | Ir ao Pacaembu |            | eu marco "Li e concordo com os termos" | eu pressiono "Enviar requisição" | eu devo ver "Nome telefone passageiros não pode ser vazio" |
    | 01210     | ronaldo@corinthians.com | 9997-3421 | Micro-ônibus - até 32 passageiros  | Aula de Campo         | Zina, Ronaldo e Alfinete |                |            | eu marco "Li e concordo com os termos" | eu pressiono "Enviar requisição" | eu devo ver "Roteiro da agenda não pode ser vazio"         |
    | 01210     | ronaldo@corinthians.com |           | Micro-ônibus - até 32 passageiros  | Outros                | Zina, Ronaldo e Alfinete | Ir ao Pacaembu |            | eu marco "Li e concordo com os termos" | eu pressiono "Enviar requisição" | eu devo ver "Celular não pode ser vazio"                   |
    | 01210     | ronaldo@corinthians     | 9997-3421 | Micro-ônibus - até 32 passageiros  | Aula de Campo         | Zina, Ronaldo e Alfinete | Ir ao Pacaembu |            | eu marco "Li e concordo com os termos" | eu pressiono "Enviar requisição" | eu devo ver "Solicitante não existe"                       |

  Cenário: Devo ver a requisição
    Dado que eu tenho uma configuração inicial
    Dado que eu sou um usuário administrador logado
    E que eu tenho uma requisição com estado "Em Espera" e id "25"
    Quando eu vou para a página da lista de requisições
    Então eu devo ver a tabela "requisicoes" com
      | Estado | Protocolo | Solicitante | Cargo     | Email                   | Data              |
      | Espera | 25        | Fulano      | Professor | fulano@uenf.br | Daqui a dois dias |

  Esquema do Cenário: Envio de requisição com datas inválidas
    Dado que eu tenho uma configuração inicial
    Dado que eu não estou logado
    E que eu tenha a categoria de veículo "Automóvel até 4 passageiros"
    E que eu tenha um objetivo de reserva "Aula de Campo"
    E que eu tenha um solicitante com e-mail "ronaldo@corinthians.com", matrícula "01210" e centro "P5"
    E que eu estou na página de requisição
    Quando eu preencho "Matrícula" com "01210"
    E eu preencho "E-mail" com "ronaldo@corinthians.com"
    E eu preencho "Data" com <Data>
    E eu seleciono "Automóvel até 4 passageiros" em "Veículo"
    E eu seleciono "Aula de Campo" em "Objetivo"
    E eu preencho "Passageiros:" com "Zina, Ronaldo e Alfinete"
    E eu preencho "Roteiro:" com "Ir ao Pacaembu"
    E eu marco "Li e concordo com os termos"
    E eu pressiono "Enviar requisição"
    Então <Sentença>

    Exemplos:(Datas invalidas)

    | Data                                             | Sentença                                                                                                                 |
    | uma data do ano que vem                          | eu devo ver "Data de reserva deve estar no ano corrente"                                                                 |
    | uma data de um dia seguinte a partir de hoje     | eu devo ver "Data de reserva deve ser no mínimo 2 dias posterior à data atual"                                           |
    | uma data de "16" dias seguintes a partir de hoje | eu devo ver "Data de reserva deve ser no máximo 15 dias posterior à data atual, para a categoria de veículo selecionada" |
    | "50/05/1986"                                     | eu devo ver "Data de reserva inválida"                                                                                   |
    | ""                                               | eu devo ver "Data de reserva não pode ser vazio"                                                                         |

  Cenário: Enviar uma requisição sem os zeros à esquerda
    Dado que eu tenho uma configuração inicial
    Dado que eu não estou logado
    Dado que eu tenha a categoria de veículo "Automóvel até 4 passageiros"
    E que eu tenha um objetivo de reserva "Aula de Campo"
    E que eu tenha um solicitante com e-mail "ronaldo@corinthians.com", matrícula "00210" e centro "P5"
    E que eu estou na página de requisição
    Quando eu preencho "Matrícula" com "210"
    E eu preencho "E-mail" com "ronaldo@corinthians.com"
    E eu preencho "Celular" com "9999-9999"
    E eu preencho "Data" com uma data de dois dias seguintes a partir de hoje
    E eu seleciono "Automóvel até 4 passageiros" em "Veículo"
    E eu seleciono "Aula de Campo" em "Objetivo"
    E eu preencho "Passageiros:" com "Zina, Ronaldo e Alfinete"
    E eu preencho "Roteiro:" com "Ir ao Pacaembu"
    E eu marco "Li e concordo com os termos"
    E eu pressiono "Enviar requisição"
    Então eu devo ver "Requisição enviada com sucesso!"

  Esquema do Cenário: Deve aceitar apenas solicitantes ativos
    Dado que eu tenho uma configuração inicial
    Dado que eu não estou logado
    Dado que eu tenha a categoria de veículo "Automóvel até 4 passageiros"
    E que eu tenha um objetivo de reserva "Aula de Campo"
    E que eu tenha um solicitante com e-mail "ronaldo@corinthians.com", matrícula "00210" e centro "P5"
    E que o solicitante esteja "<Estado>"
    E que eu estou na página de requisição
    Quando eu preencho "Matrícula" com "210"
    E eu preencho "E-mail" com "ronaldo@corinthians.com"
    E eu preencho "Celular" com "9999-9999"
    E eu preencho "Data" com uma data de dois dias seguintes a partir de hoje
    E eu seleciono "Automóvel até 4 passageiros" em "Veículo"
    E eu seleciono "Aula de Campo" em "Objetivo"
    E eu preencho "Passageiros:" com "Zina, Ronaldo e Alfinete"
    E eu preencho "Roteiro:" com "Ir ao Pacaembu"
    E eu marco "Li e concordo com os termos"
    E eu pressiono "Enviar requisição"
    Então eu devo ver "<Resposta>"

  Exemplos:
  | Estado  | Resposta                        |
  | Ativo   | Requisição enviada com sucesso! |
  | Inativo | Solicitante não existe          |


  Cenário: Mudar a viagem de uma requisição com uma viagem existente
    Dado que eu tenho uma configuração inicial
    Dado que eu sou um usuário administrador logado
    E que eu tenho uma requisição com estado "Aceita" e id "25"
    E que eu tenho uma viagem com o estado "Aguardando"
    E que a requisição esteja ligada à viagem
    E que eu tenho uma requisição com estado "Aceita" e id "27"
    E que eu tenho uma viagem com o estado "Aguardando"
    E que a requisição esteja ligada à viagem
    E que eu estou na página de detalhes da requisição
    Quando eu clico em "Alterar viagem"
    Então eu devo estar na página de aceitar a requisição
    Quando eu marco o radiobutton "escolha_de_viagem_existente"
    E eu escolho uma viagem existente diferente da requisição
    E eu pressiono "Concluir"
    Então a requisição deve estar ligada à primeira viagem
    Então eu devo ter 1 viagem cancelada

  Cenário: Mudar a viagem de uma requisição com uma nova viagem quando a viagem tem uma requisição
    Dado que eu tenho uma configuração inicial
    Dado que eu sou um usuário administrador logado
    E que eu tenho uma requisição com estado "Aceita" e id "25"
    E que eu tenho uma viagem com o estado "Aguardando"
    E que a requisição esteja ligada à viagem
    E que eu tenho um motorista com nome "Gustavo Santos"
    E que eu tenha um veículo da categoria "Automóvel até 4 passageiros", modelo "Gol" e placa "KQI 5899"
    E que eu estou na página de detalhes da requisição
    Quando eu clico em "Alterar viagem"
    Então eu devo estar na página de aceitar a requisição
    Quando eu marco o radiobutton "escolha_de_viagem_nova"
    E eu seleciono "Gustavo Santos" em "Motoristas"
    E eu seleciono "Gol - KQI 5899 - Automóvel até 4 passageiros" em "Veículo"
    E eu pressiono "Concluir"
    Então a requisição deve estar ligada à última viagem
    E eu devo ter 1 viagem cancelada

  Cenário: Mudar a viagem de uma requisição com uma nova viagem quando a viagem tem uma requisição
    Dado que eu tenho uma configuração inicial
    E que eu sou um usuário administrador logado
    E que eu tenho uma requisição com estado "Aceita" e id "25"
    E que eu tenho uma viagem com o estado "Aguardando"
    E que a requisição esteja ligada à viagem
    E que eu tenho uma requisição com estado "Aceita" e id "27"
    E que a requisição esteja ligada à viagem
    E que eu tenho um motorista com nome "Gustavo Santos"
    E que eu tenha um veículo da categoria "Automóvel até 4 passageiros", modelo "Gol" e placa "KQI 5899"
    E que eu estou na página de detalhes da requisição
    Quando eu clico em "Alterar viagem"
    Então eu devo estar na página de aceitar a requisição
    Quando eu marco o radiobutton "escolha_de_viagem_nova"
    E eu seleciono "Gustavo Santos" em "Motoristas"
    E eu seleciono "Gol - KQI 5899 - Automóvel até 4 passageiros" em "Veículo"
    E eu pressiono "Concluir"
    Então a requisição deve estar ligada à última viagem
    E eu devo ter 0 viagem cancelada

  Esquema do Cenário: Criar uma requisição sem validação
    Dado que eu tenho uma configuração inicial
    Dado que eu sou um usuário administrador logado
    E que eu tenho um solicitante com nome "Solicitante 1"
    E que eu tenha um veículo da categoria "Automóvel até 4 passageiros", modelo "Gol" e placa "KQI 5899"
    E que eu tenha um objetivo de reserva "Aula de Campo"
    E que eu tenha um objetivo de reserva "Outros"
    E que eu estou na página da lista de requisições
    Quando eu clico em "Nova requisição"
    E eu seleciono "Solicitante 1" em "Solicitante"
    E eu preencho "Celular" com "<Celular>"
    E eu preencho "Data" com "<Data>"
    E eu seleciono "<Categoria de veículo>" em "Veículo"
    E eu seleciono "<Objetivo>" em "Objetivo"
    E eu preencho "Passageiros:" com "<Nome dos passageiros>"
    E eu preencho "Roteiro:" com "<Roteiro>"
    E eu preencho "Observações" com "<Observação>"
    E eu pressiono "Salvar"
    Então eu devo ver "<Sentença>"
    E "fulano@uenf.br" deve receber 0 emails

  Exemplos:
    | Celular   | Data       | Categoria de veículo               | Objetivo              | Nome dos passageiros     | Roteiro        | Observação | Sentença                                     |
    | 9997-3421 | 25/09/2010 | Automóvel até 4 passageiros        | Aula de Campo         | Zina, Ronaldo e Alfinete | Ir ao Pacaembu |            | Requisição enviada com sucesso.              |
    | 9997-3421 | 25/09/2010 | Selecione uma categoria de veículo | Aula de Campo         | Zina, Ronaldo e Alfinete | Ir ao Pacaembu |            | Categoria de veiculo não selecionada         |
    | 9997-3421 | 25/09/2010 | Automóvel até 4 passageiros        | Selecione um objetivo | Zina, Ronaldo e Alfinete | Ir ao Pacaembu |            | Objetivo de reserva não selecionado          |
    | 9997-3421 | 25/09/2010 | Automóvel até 4 passageiros        | Aula de Campo         |                          | Ir ao Pacaembu |            | Nome telefone passageiros não pode ser vazio |
    | 9997-3421 | 25/09/2010 | Automóvel até 4 passageiros        | Aula de Campo         | Zina, Ronaldo e Alfinete |                |            | Roteiro da agenda não pode ser vazio         |
    |           | 25/09/2010 | Automóvel até 4 passageiros        | Aula de Campo         | Zina, Ronaldo e Alfinete | Ir ao Pacaembu |            | Requisição enviada com sucesso.              |
    | 9997-3421 |            | Automóvel até 4 passageiros        | Aula de Campo         | Zina, Ronaldo e Alfinete | Ir ao Pacaembu |            | Data de reserva não pode ser vazio           |
    | 9997-3421 | 25/09/2005 | Automóvel até 4 passageiros        | Aula de Campo         | Zina, Ronaldo e Alfinete | Ir ao Pacaembu |            | Requisição enviada com sucesso.              |

  Cenário: Não é possível realizar uma solicitação quando estiver definido nas configurações
    Dado que eu tenho uma configuração inicial
    E que a data inicial de proibição seja daqui a 3 dias
    E que a data final de proibição seja daqui a 5 dias
    E que eu tenha a categoria de veículo "Automóvel até 4 passageiros"
    E que eu tenha um objetivo de reserva "Aula de Campo"
    E que eu tenha um solicitante com e-mail "ronaldo@corinthians.com", matrícula "00210" e centro "P5"
    E que eu estou na página de requisição
    Quando eu preencho "Matrícula" com "210"
    E eu preencho "E-mail" com "ronaldo@corinthians.com"
    E eu preencho "Celular" com "9999-9999"
    E eu preencho "Data" com uma data de "4" dias seguintes a partir de hoje
    E eu seleciono "Automóvel até 4 passageiros" em "Veículo"
    E eu seleciono "Aula de Campo" em "Objetivo"
    E eu preencho "Passageiros:" com "Zina, Ronaldo e Alfinete"
    E eu preencho "Roteiro:" com "Ir ao Pacaembu"
    E eu marco "Li e concordo com os termos"
    E eu pressiono "Enviar requisição"
    Então eu devo ver a mensagem de proibição

  Esquema do Cenário: Não é possível requisitar carro para o ano que vem, caso esteja assim configurado
    Dado que eu tenho uma configuração inicial
    E que é possível requisitar veículo <Opção> ano
    E que eu tenha a categoria de veículo "Automóvel até 4 passageiros" padrão
    E que eu tenha um objetivo de reserva "Aula de Campo"
    E que eu tenha um solicitante com e-mail "ronaldo@corinthians.com", matrícula "00210" e centro "P5"
    E que eu estou na página de requisição
    Quando eu preencho "Matrícula" com "210"
    E eu preencho "E-mail" com "ronaldo@corinthians.com"
    E eu preencho "Celular" com "9999-9999"
    E eu preencho "Data" com uma data de "<Numero de dias>" dias seguintes a partir de hoje
    E eu seleciono "Automóvel até 4 passageiros" em "Veículo"
    E eu seleciono "Aula de Campo" em "Objetivo"
    E eu preencho "Passageiros:" com "Zina, Ronaldo e Alfinete"
    E eu preencho "Roteiro:" com "Ir ao Pacaembu"
    E eu marco "Li e concordo com os termos"
    E eu pressiono "Enviar requisição"
    Então eu devo ver "<Resposta>"

    Exemplos:
    | Opção       | Numero de dias | Resposta                                   |
    | este        | 370            | Data de reserva deve estar no ano corrente |
    | este        | 2              | Requisição enviada com sucesso             |
    | em qualquer | 370            | Requisição enviada com sucesso             |

  Esquema do Cenário: Um objetivo de reserva pode ser ou não obrigatório
    Dado que eu tenho uma configuração inicial
    E que eu tenha a categoria de veículo "Automóvel até 4 passageiros" padrão
    E que eu tenha um objetivo de reserva "Aula de Campo" <Obrigatoriedade>
    E que eu tenha um solicitante com e-mail "ronaldo@corinthians.com", matrícula "00210" e centro "P5"
    E que eu estou na página de requisição
    Quando eu preencho "Matrícula" com "210"
    E eu preencho "E-mail" com "ronaldo@corinthians.com"
    E eu preencho "Celular" com "9999-9999"
    E eu preencho "Data" com uma data de "2" dias seguintes a partir de hoje
    E eu seleciono "Automóvel até 4 passageiros" em "Veículo"
    E eu seleciono "Aula de Campo" em "Objetivo"
    E eu preencho "Passageiros:" com "Zina, Ronaldo e Alfinete"
    E eu preencho "Roteiro:" com "Ir ao Pacaembu"
    E eu preencho "Observações" com "<Observações>"
    E eu marco "Li e concordo com os termos"
    E eu pressiono "Enviar requisição"
    Então eu devo ver "<Resposta>"

    Exemplos:
    | Obrigatoriedade | Observações       | Resposta                       |
    | obrigatório     | Alguma observação | Requisição enviada com sucesso |
    | obrigatório     |                   | Observações não pode ser vazio |
    | não obrigatório | Alguma observação | Requisição enviada com sucesso |
    | não obrigatório |                   | Requisição enviada com sucesso |

  Cenário: O texto do termo deve ser definido por mim
    Dado que eu tenho uma configuração inicial
    E que o termo deve conter "<b>Texto do termo aqui</b>"
    E que eu tenha a categoria de veículo "Automóvel até 4 passageiros" padrão
    E que eu tenha um objetivo de reserva "Aula de Campo" obrigatório
    E que eu tenha um solicitante com e-mail "ronaldo@corinthians.com", matrícula "00210" e centro "P5"
    E que eu estou na página de requisição
    Então eu devo ver "Texto do termo aqui"

  @now
  Cenário: Deletar uma requisição
    Dado que eu tenho uma configuração inicial
    E que eu sou um usuário administrador logado
    E que eu tenho uma requisição com estado "Em Espera" e id "25"
    E que eu estou na página de detalhes da requisição
    Quando eu clico em "Excluir"
    Então eu devo ver "Requisição excluída com sucesso."
    E a requisição com id "25" não deve mais existir
    E eu devo estar na página da lista de requisições

  Cenário: Não é possível deletar uma requisição com viagem
    Dado que eu tenho uma configuração inicial
    E que eu sou um usuário administrador logado
    E que eu tenho uma requisição com estado "Aceitaa" e id "25"
    E que eu tenho uma viagem com o estado "Aguardando"
    E que a requisição esteja ligada à viagem
    E que eu estou na página de detalhes da requisição
    Então eu não devo ver "Excluir"

  Esquema do Cenário: Não é possível enviar uma requisição durante o fim de semana
    Dado que eu tenho uma configuração inicial
    E que eu tenha a categoria de veículo "Automóvel até 4 passageiros" padrão
    E que eu tenha um objetivo de reserva "Aula de Campo" <Obrigatoriedade>
    E que eu tenha um solicitante com e-mail "ronaldo@corinthians.com", matrícula "00210" e centro "P5"
    E que hoje é <Dia> às <Hora>
    E que eu estou na página de requisição
    Quando eu preencho "Matrícula" com "210"
    E eu preencho "E-mail" com "ronaldo@corinthians.com"
    E eu preencho "Celular" com "9999-9999"
    E eu preencho "Data" com uma data de "<Dias para requisição>" dias seguintes a partir de hoje
    E eu seleciono "Automóvel até 4 passageiros" em "Veículo"
    E eu seleciono "Aula de Campo" em "Objetivo"
    E eu preencho "Passageiros:" com "Zina, Ronaldo e Alfinete"
    E eu preencho "Roteiro:" com "Ir ao Pacaembu"
    E eu preencho "Observações" com "<Observações>"
    E eu marco "Li e concordo com os termos"
    E eu pressiono "Enviar requisição"
    Então eu devo ver "<Resposta>"
    E que o Timecop volta ao normal

    Exemplos:
    | Dia         | Hora     | Dias para requisição | Resposta                                                              |
    | Sexta-Feira | 17:59:00 | 1                    | Requisição enviada com sucesso!                                       |
    | Sexta-Feira | 18:01:00 | 0                    | Requisição não pode ser feita após o expediente para o fim de semana. |
    | Sexta-Feira | 18:00:00 | 1                    | Requisição não pode ser feita após o expediente para o fim de semana. |
    | Sexta-Feira | 10:00:00 | 2                    | Requisição enviada com sucesso!                                       |
    | Sexta-Feira | 13:59:00 | 3                    | Requisição enviada com sucesso!                                       |
    | Sexta-Feira | 18:00:00 | 4                    | Requisição enviada com sucesso!                                       |
    | Sábado      | 13:59:00 | 0                    | Requisição não pode ser feita após o expediente para o fim de semana. |
    | Sábado      | 13:59:00 | 1                    | Requisição não pode ser feita após o expediente para o fim de semana. |
    | Sábado      | 13:59:00 | 2                    | Requisição não pode ser feita após o expediente para o fim de semana. |
    | Sábado      | 13:59:00 | 4                    | Requisição enviada com sucesso!                                       |
    | Domingo     | 13:59:00 | 0                    | Requisição não pode ser feita após o expediente para o fim de semana. |
    | Domingo     | 13:59:00 | 1                    | Requisição não pode ser feita após o expediente para o fim de semana. |
    | Domingo     | 13:59:00 | 2                    | Requisição enviada com sucesso!                                       |

