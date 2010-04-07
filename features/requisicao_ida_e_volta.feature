#language: pt

Funcionalidade: Verificar se a requisição de ida e volta estão corretas
    Como um administrador
    Eu quero verificar se posso ver as requisições de ida e volta
    Para que eu possa ter um maior melhor controle

    Esquema do Cenário: Devo ver a requisição de ida e de volta
      Dado que eu tenha um solicitante com e-mail "ronaldo@corinthians.com", matrícula "01210" e prédio "P5"
      E que eu tenho uma requisição de ida com número de protocolo <id_ida>
      E que eu tenho uma requisição de volta com número de protocolo <id_volta>
      Quando eu vou para a "página da lista de requisições"
      Então eu devo ver a tabela "requisicoes" com
        | Estado | Protocolo  | Solicitante | Cargo     | Email                   | Telefone     | Data                | Veículo                           | Objetivo       | Tipo   | Referência |
        | Espera | <id_ida>   | Fulano      | Professor | ronaldo@corinthians.com | 2222-2222    | Daqui a dois dias   | Micro-ônibus - até 32 passageiros | Aula de Campo  | Ida    | <id_volta> |
        | Espera | <id_volta> | Fulano      | Professor | ronaldo@corinthians.com | 2222-2222    | Daqui a quatro dias | Micro-ônibus - até 32 passageiros | Aula de Campo  | Volta  | <id_ida>   |

    Exemplos:
    | id_ida | id_volta |
    | 3      | 5        |
    | 1      | 3        |

