# language: pt

Funcionalidade: Adicionar uma categoria de veículo

Como um administrador
Eu quero adicionar uma nova categoria de veículo
Para que eu possa utiliza-la no sistema

  Esquema do Cenário: Adicionar categoria de veículo
    Dado que eu estou na página de adição de categoria de veículo
    Quando eu preencho "Nome" com "<nome>"
    E eu pressiono "Criar Categoria de veículo"
    Então eu devo ver "<sentença>"

    Exemplos:

    | nome                        | sentença                                 |
    | Automóvel até 4 passageiros | Categoria de veículo criada com sucesso! |
    |                             | Nome não pode ser vazio                  |


  Esquema do Cenário: Editar categoria de veículo
    Dado que eu tenha a categoria de veículo "Automóvel até 4 passageiros"
    E que eu estou na página de edição de categoria de veículo
    Quando eu preencho "Nome" com "<nome>"
    E eu pressiono "Atualizar"
    Então eu devo ver "<sentença>"

    Exemplos:

    | nome                        | sentença                                     |
    | Automóvel até 6 passageiros | Categoria de veículo modificada com sucesso! |
    |                             | Nome não pode ser vazio                      |

  Esquema do Cenário: Ativar/Desativar uma categoria de veículo pela página de edição
    Dado que eu tenha a categoria de veículo "4 Passageiros"
    E que a categoria de veículo esteja "<Estado do Solicitante>"
    E que eu estou na página de edição do categoria de veículo
    Quando eu seleciono "<Estado desejado>" em "Estado"
    E eu pressiono "Atualizar"
    Então eu devo ver "Estado: <Estado desejado>"

  Exemplos:
  | Estado do Solicitante | Estado desejado |
  | Ativo                 | Inativo         |
  | Inativo               | Ativo           |


  Esquema do Cenário: Deve mostrar apenas categorias de veículo ativos
    Dado que eu tenha a categoria de veículo "Automóvel até 4 passageiros"
    E que a categoria de veículo esteja "<Estado>"
    E que eu tenha um objetivo de reserva "Aula de Campo"
    E que eu estou na página de requisição
    Então eu <Visão>

  Exemplos:
  | Estado  | Visão                                      |
  | Ativo   | devo ver "Automóvel até 4 passageiros"     |
  | Inativo | não devo ver "Automóvel até 4 passageiros" |

