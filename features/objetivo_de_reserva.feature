# language: pt

Funcionalidade: Manipular um objetivo de reserva

Como um administrador
Eu quero manipular um objetivo de reserva
Para que eu possa adicinar, editar e utilizar no sistema

  Esquema do Cenário: Adicionar objetivo de reserva
    Dado que eu estou na página de adição de objetivo de reserva
    Quando eu preencho "Texto" com "<texto>"
    E eu pressiono "Criar"
    Então eu devo ver "<sentença>"

    Exemplos:

    | texto         | sentença                                |
    | Aula de Campo | Objetivo de reserva criado com sucesso! |
    |               | Texto não pode ser vazio                |

  Esquema do Cenário: Editar objetivo de reserva
    Dado que eu tenha um objetivo de reserva "Aula de Campo"
    E que eu estou na página de edição do objetivo de reserva
    Quando eu preencho "Texto" com "<texto>"
    E eu pressiono "Atualizar"
    Então eu devo ver "<sentença>"

    Exemplos:

    | texto           | sentença                                    |
    | Aula de Campo 2 | Objetivo de reserva modificado com sucesso! |
    |                 | Texto não pode ser vazio                    |

  Esquema do Cenário: Ativar/Desativar um objetivo de reserva pela página de edição
    Dado que eu tenha um objetivo de reserva "Aula de Campo"
    E que o objetivo de reserva esteja "<Estado do Objetivo>"
    E que eu estou na página de edição do objetivo de reserva
    Quando eu seleciono "<Estado desejado>" em "Estado"
    E eu pressiono "Atualizar"
    Então eu devo ver "Estado: <Estado desejado>"

  Exemplos:
  | Estado do Objetivo | Estado desejado |
  | Ativo              | Inativo         |
  | Inativo            | Ativo           |

  Esquema do Cenário: Deve mostrar apenas objetivos de reserva ativos
    Dado que eu tenha uma categoria de veículo "Automóvel até 4 passageiros"
    E que eu tenha um objetivo de reserva "Aula de Campo"
    E que o objetivo de reserva esteja "<Estado>"
    E que eu estou na página de requisição
    Então eu <Visão>

  Exemplos:
  | Estado  | Visão                        |
  | Ativo   | devo ver "Aula de Campo"     |
  | Inativo | não devo ver "Aula de Campo" |

