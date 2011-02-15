#language: pt
Funcionalidade: Configurar o sistema

Como um administrador
Eu quero configurar o sistema
Para que ele possa se adaptar as minhas necessidades

  Cenário: Mudar o nome da instituição do sistema
    Dado que eu tenho uma configuração inicial
    E que eu sou um usuário administrador logado
    Quando eu clico em "Configurações"
    E eu clico em "Instituição utilizadora"
    E eu preencho "Nome" com "CEDERJ"
    E eu pressiono "Salvar"
    Então eu devo ver "Configurações atualizadas com sucesso."
    E eu devo estar na página das configurações
    Quando eu clico em "Requisições"
    Então eu devo ver "CEDERJ"

  Cenário: Mudar o nome do setor de transporte
    Dado que eu tenho uma configuração inicial
    E que eu sou um usuário administrador logado
    Quando eu clico em "Configurações"
    E eu clico em "Instituição utilizadora"
    E eu preencho "Setor de transporte" com "ASTRAN"
    E eu pressiono "Salvar"
    Então eu devo ver "Configurações atualizadas com sucesso."
    E eu devo estar na página das configurações
    Quando eu clico em "Requisições"
    Então eu devo ver "ASTRAN"

  Cenário: Somente usuário administrador podem entrar nas configurações
    Dado que eu tenho uma configuração inicial
    E que eu sou um usuário visitante logado
    Quando eu clico em "Configurações"
    Então eu devo ver "Seu privilégio não permite realizar esta operação."

  Cenário: Retirar formulário de requisição do ar
    Dado que eu tenho uma configuração inicial
    E que eu sou um usuário administrador logado
    Quando eu clico em "Configurações"
    E eu clico em "Formulário de requisição"
    E eu desmarco "Formulário ativo"
    E eu pressiono "Salvar"
    Então eu devo ver "Configurações atualizadas com sucesso."
    Quando eu clico em "Sair"
    E eu vou para a página de requisição
    Então eu devo ver "A requisição de veículos está temporariamente indisponível."

  Cenário: Colocar formulário de requisição do ar
    Dado que eu tenho uma configuração inicial
    E que o formulário de requisição está fora do ar
    E que eu sou um usuário administrador logado
    Quando eu clico em "Configurações"
    E eu clico em "Formulário de requisição"
    E eu marco "Formulário ativo"
    E eu pressiono "Salvar"
    Então eu devo ver "Configurações atualizadas com sucesso."
    Quando eu clico em "Sair"
    E eu vou para a página de requisição
    Então eu devo ver "Requisição de veículo"
    Então eu devo ver "Matrícula:"
    Então eu devo ver "Objetivo:"

  Cenário: Definir intervalo de datas que não é possível agendar uma requisição
    Dado que eu tenho uma configuração inicial
    E que eu sou um usuário administrador logado
    Quando eu clico em "Configurações"
    E eu clico em "Formulário de requisição"
    E eu preencho "Data inicial" com uma data de "3" dias seguintes a partir de hoje
    E eu preencho "Data final" com uma data de "5" dias seguintes a partir de hoje
    E eu pressiono "Salvar"
    Então eu devo ver "Configurações atualizadas com sucesso."

  Cenário: Ter a opção para fazer as requisições somente para o ano corrente
    Dado que eu tenho uma configuração inicial
    E que eu sou um usuário administrador logado
    Quando eu clico em "Configurações"
    E eu clico em "Formulário de requisição"
    E eu marco "Ano corrente"
    E eu pressiono "Salvar"
    Então eu devo ver "Configurações atualizadas com sucesso."

  Cenário: Editar a mensagem do termo do formulário de requisição
    Dado que eu tenho uma configuração inicial
    E que eu sou um usuário administrador logado
    Quando eu clico em "Configurações"
    E eu clico em "Formulário de requisição"
    E eu preencho "Termo" com "<b>Algum termo aqui</b>"
    E eu pressiono "Salvar"
    Então eu devo ver "Configurações atualizadas com sucesso."

  Cenário: Colocar formulário de requisição do ar
    Dado que eu tenho uma configuração inicial
    E que o formulário de requisição está fora do ar
    E que eu sou um usuário administrador logado
    Quando eu clico em "Configurações"
    E eu clico em "Formulário de requisição"
    E eu marco "Não permitir requisição durante o fim de semana:"
    E eu pressiono "Salvar"
    Então eu devo ver "Configurações atualizadas com sucesso."

  Cenário: Mudar nome do centro no sistema
    Dado que eu tenho uma configuração inicial
    E que eu sou um usuário administrador logado
    Quando eu clico em "Configurações"
    E eu clico em "Instituição utilizadora"
    E eu preencho "Unidade hierárquica" com "Setor"
    E eu pressiono "Salvar"
    Então eu devo ver "Configurações atualizadas com sucesso."
    E todos os campos Centro devem estar como Setor

  Cenário: Adicionar o e-mail da instituição para envio ao usuário
    Dado que eu tenho uma configuração inicial
    E que eu sou um usuário administrador logado
    Quando eu clico em "Configurações"
    E eu clico em "Instituição utilizadora"
    E eu preencho "E-mail" com "agendas@email.com"
    E eu pressiono "Salvar"
    Então eu devo ver "Configurações atualizadas com sucesso."

