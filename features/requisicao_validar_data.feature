# language: pt

  Esquema do Cenário: Envio de requisição com datas inválidas
    Dado que eu tenha uma categoria de veículo "Micro-ônibus - até 32 passageiros"
    E que eu tenha um solicitante com e-mail "ronaldo@corinthians.com" e matricula "01210"
    E que eu estou na página de requisição
    Quando eu preencho "Matrícula" com "01210"
    E eu preencho "E-mail" com "ronaldo@corinthians.com"
    E eu preencho "Cargo ou Função" com "Aluno"
    E eu preencho "Telefone ou Ramal" com "2739-1689"
    E eu preencho "Laboratório ou Setor" com "LCMAT"
    E eu seleciono "P5" em "Prédio"
    E eu seleciono "1º andar" em "Andar"
    E eu preencho "Sala" com "121"
    E <Ida_e_Volta>
    E <Opção>
    E eu preencho "Data de Reserva de Ida" com <Data>
    E eu seleciono "Micro-ônibus - até 32 passageiros" em "Categoria de veículo"
    E eu seleciono "Aula de Campo" em "Objetivo da Reserva"
    E eu preencho "Nome(s) e telefone do(s) passageiro(s):" com "Zina, Ronaldo e Alfinete"
    E eu preencho "Roteiro da agenda:" com "Ir ao Pacaembu"
    E eu marco "Li e concordo com os termos"
    E eu pressiono "Enviar"
    Então <Sentença>

    Exemplos:(Datas invalidas)

    | Ida_e_Volta                             | Opção                                                  | Data                                             | Sentença                                                                          |
    | eu escolho requisição de "Ida"          | eu preencho data de reserva de volta com ""            | uma data do ano que vem                          | eu devo ver "Data de reserva deve estar no ano corrente"                          |
    | eu escolho requisição de "Ida"          | eu preencho data de reserva de volta com ""            | uma data de um dia seguinte a partir de hoje     | eu devo ver "Data de reserva deve ser no mínimo 2 dias posterior à data atual"    |
    | eu escolho requisição de "Ida"          | eu preencho data de reserva de volta com ""            | "50/05/1986"                                     | eu devo ver "Data de reserva inválida"                                            |
    | eu escolho requisição de "Ida"          | eu preencho data de reserva de volta com ""            | ""                                               | eu devo ver "Data de reserva não pode ser vazio"                                  |
    | eu escolho requisição de "Ida e Volta"  | eu preencho data de reserva de volta com "35/05/2010"  | uma data de dois dias seguintes a partir de hoje | eu devo ver "Data de reserva inválida"                                            |
    | eu escolho requisição de "Ida e Volta"  | eu preencho data de reserva de volta com ""            | uma data de dois dias seguintes a partir de hoje | eu devo ver "Data de reserva não pode ser vazio"                                  |

