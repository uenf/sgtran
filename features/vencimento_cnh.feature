# language: pt

Funcionalidade: Avisar que a CNH está para vencer

Como um administrador
Eu quero receber um aviso que a CNH do motorista está para vencer
Para que eu possa informá-lo quanto a renovação

    Cenário: Aviso de vencimento
        Dado que eu tenho um motorista com nome "Gustavo Santos"
        E que sua carteira irá vencer em "30" dias
        E que ele não está avisado sobre o vencimento deu sua cnh
        E que eu estou na página de visualização de requisições
        Então eu devo ver "Existe(m) motorista(s) com a carteira para vencer"

    Cenário: Verificar quais motoristas estão com a carteira para vencer e dizer que não precisa mais do aviso
        Dado que eu tenho um motorista com nome "Gustavo Santos"
        E que sua carteira irá vencer em "30" dias
        E que ele não está avisado sobre o vencimento deu sua cnh
        E que eu estou na página de visualização de requisições
        Quando eu clico em "Ver avisos"
        Então eu devo estar na página de motoristas com CNH para vencer
        E eu devo ver "Gustavo Santos"

        Quando eu pressiono "Ok, esconder aviso"
        Então eu devo estar na página de visualização de requisições
        E eu não devo ver "Existe(m) motorista(s) com a carteira para vencer"

