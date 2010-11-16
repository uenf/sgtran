#language: pt

Funcionalidade: Verificar se a requisição de ida e volta estão corretas
  Como um administrador
  Eu quero verificar se posso ver as requisições de ida e volta
  Para que eu possa ter um maior melhor controle

  Esquema do Cenário: Devo ver a requisição de ida e de volta
    Dado que eu sou um usuário administrador logado
    Dado que eu tenha um solicitante com e-mail "ronaldo@corinthians.com", matrícula "01210" e centro "P5"
    E que eu tenho uma requisição de ida com número de protocolo <id_ida>
    E que eu tenho uma requisição de volta com número de protocolo <id_volta>
    Quando eu vou para a "página da lista de requisições"
    Então eu devo ver a tabela "requisicoes" com
      | Estado | Protocolo  | Solicitante | Cargo     | Email                   | Data                | Tipo  | Referência |
      | Espera | <id_ida>   | Fulano      | Professor | ronaldo@corinthians.com | Daqui a dois dias   | Ida   | <id_volta> |
      | Espera | <id_volta> | Fulano      | Professor | ronaldo@corinthians.com | Daqui a quatro dias | Volta | <id_ida>   |

    Exemplos:
    | id_ida | id_volta |
    | 3      | 5        |
    | 1      | 3        |


  Esquema do Cenário: Envio de requisição
    Dado que eu não estou logado
    E que eu tenha a categoria de veículo "Micro-ônibus - até 32 passageiros"
    E que eu tenha um objetivo de reserva "Aula de Campo"
    E que eu tenha um objetivo de reserva "Outros"
    E que eu tenha um solicitante com e-mail "ronaldo@corinthians.com", matrícula "01210" e centro "P5"
    E que eu estou na página de requisição
    Quando eu preencho "Matrícula" com "<Matrícula>"
    E eu preencho "E-mail" com "<E-mail>"
    E eu preencho "Celular" com "<Celular>"
    E eu escolho requisição de "Ida e Volta"
    E eu preencho "Data de Reserva de Ida" com uma data de "2" dias seguintes a partir de hoje
    E eu preencho "Data de Reserva de Volta" com uma data de "4" dias seguintes a partir de hoje
    E eu seleciono "<Categoria de veículo>" em "Categoria de veículo"
    E eu seleciono "<Objetivo>" em "Objetivo da Reserva"
    E eu preencho "Outros" com "<Outros>"
    E eu preencho "Nome e telefone dos passageiros:" com "<Nome_passageiros>"
    E eu preencho "Roteiro da agenda (ida):" com "<Roteiro>"
    E eu preencho "Roteiro da agenda (volta):" com "<Roteiro>"
    E eu preencho "Observação" com "<Observação>"
    E <Termo>
    E <Ação>
    Então <Sentença>
    E eu devo ter 2 requisições
    E "ronaldo@corinthians.com" deve receber 2 emails


    Exemplos:(Requisição enviada com sucesso)

    | Matrícula | E-mail                     | Celular   | Categoria de veículo              | Objetivo              | Outros    | Nome_passageiros          | Roteiro           | Observação    | Termo                                      | Ação                  | Sentença                                      |
    | 01210     | ronaldo@corinthians.com    | 9997-3421 | Micro-ônibus - até 32 passageiros | Aula de Campo         |           | Zina, Ronaldo e Alfinete  | Ir ao Pacaembu    |               | eu marco "Li e concordo com os termos"     | eu pressiono "Enviar" | eu devo ver "Requisição enviada com sucesso!" |
    | 01210     | ronaldo@corinthians.com    | 9997-3421 | Micro-ônibus - até 32 passageiros | Outros                | Bla       | Zina, Ronaldo e Alfinete  | Ir ao Pacaembu    |               | eu marco "Li e concordo com os termos"     | eu pressiono "Enviar" | eu devo ver "Requisição enviada com sucesso!" |

