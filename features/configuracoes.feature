#language: pt
Funcionalidade: Configurar o sistema

Como um administrador
Eu quero configurar o sistema
Para que ele possa se adaptar as minhas necessidades

  Cenário: Mudar o nome do órgão utilizador do sistema
    Dado que eu tenho uma configuração inicial
    E que eu sou um usuário administrador logado
    Quando eu clico em "Configurações"
    E eu preencho "Órgão utilizador" com "CEDERJ"
    E eu pressiono "Salvar"
    Então eu devo ver "Configurações atualizadas com sucesso."
    E eu devo estar na página de edição das configurações
    Quando eu clico em "Requisições"
    Então eu devo ver "CEDERJ"

  Cenário: Somente usuário administrador podem entrar nas configurações
    Dado que eu tenho uma configuração inicial
    E que eu sou um usuário visitante logado
    Quando eu clico em "Configurações"
    Então eu devo ver "Seu privilégio não permite realizar esta operação."
