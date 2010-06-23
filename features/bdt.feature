#language: pt

Funcionalidade: Fechar viagem com o BDT
    Como um administrador
    Eu quero fechar uma viagem com o BDT
    Para que eu finalizar o ciclo de uma ou mais requisições, e com esses dados fazer relatórios mais completos

    Cenário: Fechar viagem com o BDT
        Dado que eu tenho uma requisição com estado "Aceita"
        E que eu tenho uma viagem com o estado "Aguardando"
        E que a requisição esteja ligada à viagem
        E que eu estou na página de visualização da viagem
        Quando eu clico em "Fechar viagem"
        Então eu devo estar na página de criação do BDT

