# language: pt

Funcionalidade: Visualizar botões de mudança de estado corretos

    Como um administrador
    Eu quero ver apenas botões de mudança de estado que estejam aptos a aparecer para cada requisição
    Para que eu não coloque um estado errado em uma requisição

    Esquema do Cenário: Requisição com diversos estados
      Dado que eu tenha uma requisição com estado <Estado>
      Quando eu vou para a "página de detalhes da requisição"
      Então <Botão Aceitar>
      E <Botão Rejeitar>
      E <Botão Cancelar>

      Exemplos:(Botões que devem ser vistos)

      | Estado                        | Botão Aceitar             | Botão Rejeitar             | Botão Cancelar              |
      | "Espera"                      | eu devo ver "Aceitar"     | eu devo ver "Rejeitar"     | eu não devo ver "Cancelar"  |
      | "Aceita"                      | eu não devo ver "Aceitar" | eu não devo ver "Rejeitar" | eu devo ver "Cancelar"      |
      | "Rejeitada"                   | eu devo ver "Aceitar"     | eu não devo ver "Rejeitar" | eu não devo ver "Cancelar"  |
      | "Cancelado pelo professor"    | eu não devo ver "Aceitar" | eu não devo ver "Rejeitar" | eu não devo ver "Cancelar"  |
      | "Cancelado pelo sistema"      | eu devo ver "Aceitar"     | eu não devo ver "Rejeitar" | eu não devo ver "Cancelar"  |
      | "Atendida"                    | eu não devo ver "Aceitar" | eu não devo ver "Rejeitar" | eu não devo ver "Cancelar"  |

