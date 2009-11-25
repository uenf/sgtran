#language: pt
Funcionalidade: Verificar a aba Base de Dados
    Como um administrador
    Eu quero editar os dados
    Para que eu possa ter controle do sistema

    Esquema do Cenário:
    Dado que eu estou logado
    Quando eu clico em "Base de Dados"
    Então eu devo ver "<Campo>"

    Exemplos:
    | Campo         |
    | Email  |

