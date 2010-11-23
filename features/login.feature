#language: pt


Funcionalidade: Login para o sistema
  Como um administrador
  Eu quero entrar no sistema
  Para que eu possar gerenciar as requisições

  Esquema do Cenário:
    Dado que eu tenho uma configuração inicial
    Dado que eu tenho um usuário administrador com login "sgtran" e senha "teste"
    E que eu tenho uma requisição com solicitante "<Solicitante>"
    E que eu não estou logado
    E que eu estou na página de login
    Quando eu preencho "Login" com "<Login>"
    E eu preencho "Senha" com "<Senha>"
    E eu pressiono "Entrar"
    Entao <Ação>

    Exemplos:
     | Solicitante | Login  | Senha | Ação                                         |
     | Pedro       | sgtran | teste | eu devo ver "Pedro"                          |
     | Pedro       | sgtran |       | eu devo ver "Senha não pode ficar em branco" |
     | Pedro       |        | admin | eu devo ver "Login não pode ficar em branco" |
     | Pedro       | sgtran | admin | eu devo ver "Senha ou login inválidos."      |
     | Pedro       | admin  | admin | eu devo ver "Login ou senha inválidos."      |

  Esquema do Cenário: Usuário não logado deve sempre ser redirecionado para a página de requisições
    Dado que eu tenho uma configuração inicial
    Dado que eu não estou logado
    Quando eu vou para a <Página desejada>
    Então eu devo estar na página de requisição

    Exemplos:
     | Página desejada                        |
     | página de visualização de requisições  |
     | página de visualização de motoristas   |
     | página de visualização de solicitantes |
     | página de visualização de usuarios     |
     | página de visualização de viagens      |

  Esquema do Cenário: Usuário logado deve ser redirecionado para a página de que dejeja normalmente
    Dado que eu tenho uma configuração inicial
    Dado que eu sou um usuário administrador logado
    Quando eu vou para a <Página desejada>
    Então eu devo estar na <Página desejada>

    Exemplos:
     | Página desejada                        |
     | página de visualização de requisições  |
     | página de visualização de motoristas   |
     | página de visualização de solicitantes |
     | página de visualização de usuarios     |
     | página de visualização de viagens      |

  Cenário: Usuário logado deve ser redirecionado caso acesse a página de login
    Dado que eu tenho uma configuração inicial
    Dado que eu sou um usuário administrador logado
    Quando eu vou para a página de login
    Então eu devo estar na página de visualização de requisições

  Cenário: Usuário que não esteja logado deve ver a página de login
    Dado que eu tenho uma configuração inicial
    Dado que eu não estou logado
    Quando eu vou para a página de login
    Então eu devo estar na página de login

