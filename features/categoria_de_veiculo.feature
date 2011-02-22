# language: pt

Funcionalidade: Adicionar uma categoria de veículo

Como um administrador
Eu quero adicionar uma nova categoria de veículo
Para que eu possa utiliza-la no sistema

  @now
  Esquema do Cenário: Adicionar categoria de veículo
    Dado que eu tenho uma configuração inicial
    E que eu sou um usuário administrador logado
    E que eu estou na página de adição de categoria de veículo
    Quando eu preencho "Nome" com "<Nome>"
    E eu preencho "Mínimo:" com "<Mínimo>"
    E eu preencho "Máximo:" com "<Máximo>"
    E eu pressiono "Salvar"
    Então eu devo ver "<Sentença>"

    Exemplos:

    | Nome                        | Mínimo | Máximo | Sentença                                 |
    | Automóvel até 4 passageiros | 1      | 15     | Categoria de veículo criada com sucesso! |
    | Automóvel até 4 passageiros | 0      | 15     | Categoria de veículo criada com sucesso! |
    | Automóvel até 4 passageiros | 0      | 0      | Categoria de veículo criada com sucesso! |
    | Automóvel até 4 passageiros | 13     | 0      | Categoria de veículo criada com sucesso! |
    | Automóvel até 4 passageiros | 13     | 13     | Categoria de veículo criada com sucesso! |
    |                             | 1      | 15     | Nome não pode ser vazio                  |

  Esquema do Cenário: Editar categoria de veículo
    Dado que eu tenho uma configuração inicial
    E que eu sou um usuário administrador logado
    E que eu tenha a categoria de veículo "Automóvel até 4 passageiros"
    E que eu estou na página de edição de categoria de veículo
    Quando eu preencho "Nome" com "<nome>"
    E eu pressiono "Salvar"
    Então eu devo ver "<sentença>"

    Exemplos:

    | nome                        | sentença                                     |
    | Automóvel até 6 passageiros | Categoria de veículo modificada com sucesso! |
    |                             | Nome não pode ser vazio                      |

  Esquema do Cenário: Ativar/Desativar uma categoria de veículo pela página de edição
    Dado que eu tenho uma configuração inicial
    E que eu sou um usuário administrador logado
    E que eu tenha a categoria de veículo "4 Passageiros"
    E que a categoria de veículo esteja "<Status do Solicitante>"
    E que eu estou na página de edição do categoria de veículo
    Quando eu seleciono "<Status desejado>" em "Status"
    E eu pressiono "Salvar"
    Então eu devo ver "Status: <Status desejado>"

    Exemplos:
    | Status do Solicitante | Status desejado |
    | Ativo                 | Inativo         |
    | Inativo               | Ativo           |


  Esquema do Cenário: Deve mostrar apenas categorias de veículo ativos
    Dado que eu tenho uma configuração inicial
    E que eu sou um usuário administrador logado
    E que eu tenha a categoria de veículo "Automóvel até 4 passageiros"
    E que a categoria de veículo esteja "<Status>"
    E que eu tenha um objetivo de reserva "Aula de Campo"
    E que eu estou na página de requisição
    Então eu <Visão>

    Exemplos:
    | Status  | Visão                                      |
    | Ativo   | devo ver "Automóvel até 4 passageiros"     |
    | Inativo | não devo ver "Automóvel até 4 passageiros" |

