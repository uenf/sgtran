#language: pt

Funcionalidade: Inserir um novo usuário
    Como um administrador
    Eu quero inserir um novo usuário
    Para que eu possa dar acesso a quem eu quiser

    Esquema do Cenário:
        Dado que eu estou logado
        E que eu estou na página de usuário
        Quando eu preencho "Nome" com "<Nome>"
        E eu preencho "Login" com "<Login>"
        E eu preencho "E-mail" com "<E-mail>"
        E eu preencho "Senha" com "<Senha>"
        E eu preencho "Confirme a senha" com "<Confirmação>"
        E eu seleciono "<Privilégio>" em "Privilégio"
        E eu pressiono "Salvar"
        Então eu devo ver "<Resposta>"

        Exemplos:
        | Nome | Login | E-mail          | Senha | Confirmação | Privilégio    | Resposta                                          |
        | João | teste | teste@teste.com | teste | teste       | Administrador | teste@teste.com                                   |
        | João | teste | teste@teste.com | teste | teste       | Visitante     | teste@teste.com                                   |
        |      | teste | teste@teste.com | teste | teste       | Administrador | Nome não pode ser vazio                           |
        | João |       | teste@teste.com | teste | teste       | Administrador | Login não pode ser vazio                          |
        | João | teste | teste@teste.com |       | teste       | Administrador | Password não pode ser vazio                       |
        | João | teste |                 |       | teste       | Administrador | Email não pode ser vazio                          |
        | João | teste | teste.com       | teste | teste       | Administrador | Email deve ser semelhante a um endereço de email. |

