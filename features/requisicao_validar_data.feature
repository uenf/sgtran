# language: pt

Funcionalidade: Validar data da requisição

Como um administrador
Eu quero que a data da requisição seja válida
Para que eu não tenha problemas com a gerência das requisições

  Esquema do Cenário: Envio de requisição com datas inválidas
    Dado que eu tenho uma configuração inicial
    Dado que eu não estou logado
    Dado que eu tenha a categoria de veículo "Micro-ônibus - até 32 passageiros"
    E que eu tenha um objetivo de reserva "Aula de Campo"
    E que eu tenha um solicitante com e-mail "ronaldo@corinthians.com", matrícula "01210" e centro "P5"
    E que eu estou na página de requisição
    Quando eu preencho "Matrícula" com "01210"
    E eu preencho "E-mail" com "ronaldo@corinthians.com"
    E eu preencho "Celular" com "9958-1425"
    E eu preencho "Data" com <Data>
    E eu seleciono "Micro-ônibus - até 32 passageiros" em "Veículo"
    E eu seleciono "Aula de Campo" em "Objetivo"
    E eu preencho "Passageiros:" com "Zina, Ronaldo e Alfinete"
    E eu preencho "Roteiro:" com "Ir ao Pacaembu"
    E eu marco "Li e concordo com os termos"
    E eu pressiono "Enviar solicitação"
    Então <Sentença>

    Exemplos:(Datas invalidas)

    | Data                                             | Sentença                                                                       |
    | uma data do ano que vem                          | eu devo ver "Data de reserva deve estar no ano corrente"                       |
    | uma data de um dia seguinte a partir de hoje     | eu devo ver "Data de reserva deve ser no mínimo 2 dias posterior à data atual" |
    | "50/05/1986"                                     | eu devo ver "Data de reserva inválida"                                         |
    | uma data vazia                                   | eu devo ver "Data de reserva não pode ser vazio"                               |

