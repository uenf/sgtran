#language: pt
Funcionalidade: Verificar a aba Base de Dados
    Como um administrador
    Eu quero editar os dados
    Para que eu possa ter controle do sistema

    Esquema do Cenário:
      Dado que eu tenho uma configuração inicial
      Dado que eu sou um usuário administrador logado
      Quando eu clico em "Base de Dados"
      Então eu devo ver "<item>"

      Exemplos:
      | item                  |
      | Usuários              |
      | Solicitantes          |
      | Motoristas            |
      | Veículos              |
      | Combustíveis          |
      | Categorias de veículo |
      | Motivos               |

