# language: pt

Funcionalidade: Visualizar botões de mudança de estado corretos

    Como um administrador
    Eu quero ver apenas botões de mudança de estado que estejam aptos a aparecer para cada requisição
    Para que eu não coloque um estado errado em uma requisição

    Esquema do Cenário: Requisição com diversos estados
      Dado que eu tenho uma requisição com estado <Estado>
      Quando eu vou para a "página de detalhes da requisição"
      Então <Botão Aceitar>
      E <Botão Rejeitar>
      E <Botão Cancelar>

      Exemplos:(Botões que devem ser vistos)

      | Estado                        | Botão Aceitar             | Botão Rejeitar             | Botão Cancelar              |
      | "Em Espera"                   | eu devo ver "Aceitar"     | eu devo ver "Rejeitar"     | eu não devo ver "Cancelar"  |
      | "Aceita"                      | eu não devo ver "Aceitar" | eu não devo ver "Rejeitar" | eu devo ver "Cancelar"      |
      | "Rejeitada"                   | eu devo ver "Aceitar"     | eu não devo ver "Rejeitar" | eu não devo ver "Cancelar"  |
      | "Cancelada pelo Professor"    | eu não devo ver "Aceitar" | eu não devo ver "Rejeitar" | eu não devo ver "Cancelar"  |
      | "Cancelada pelo Sistema"      | eu devo ver "Aceitar"     | eu não devo ver "Rejeitar" | eu não devo ver "Cancelar"  |

