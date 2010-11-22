# language: pt

Funcionalidade: Visualizar botões de mudança de estado corretos

  Como um administrador
  Eu quero ver apenas botões de mudança de estado que estejam aptos a aparecer para cada requisição
  Para que eu não coloque um estado errado em uma requisição

  Esquema do Cenário: Requisição com diversos estados
    Dado que eu tenho uma configuração inicial
    Dado que eu sou um usuário administrador logado
    E que eu tenho uma requisição com estado <Estado> e id "25"
    Quando eu vou para a página de detalhes da requisição
    Então <Botão Aceitar>
    E <Botão Rejeitar>
    E <Botão Cancelar>

    Exemplos:(Botões que devem ser vistos)
    | Estado                     | Botão Aceitar             | Botão Rejeitar             | Botão Cancelar             |
    | "Em Espera"                | eu devo ver "Aceitar"     | eu devo ver "Rejeitar"     | eu não devo ver "Cancelar" |
    | "Rejeitada"                | eu devo ver "Aceitar"     | eu não devo ver "Rejeitar" | eu não devo ver "Cancelar" |
    | "Cancelada pelo Professor" | eu não devo ver "Aceitar" | eu não devo ver "Rejeitar" | eu não devo ver "Cancelar" |
    | "Cancelada pelo Sistema"   | eu não devo ver "Aceitar" | eu não devo ver "Rejeitar" | eu não devo ver "Cancelar" |

  Cenário: Requisição com o estado Aceitar
    Dado que eu tenho uma configuração inicial
    Dado que eu sou um usuário administrador logado
    E que eu tenho uma requisição com estado "Aceita" e id "25"
    E que eu tenho uma viagem com o estado "Aguardando"
    E que a requisição esteja ligada à viagem
    Quando eu vou para a página de detalhes da requisição
    Então eu não devo ver "Aceitar"

