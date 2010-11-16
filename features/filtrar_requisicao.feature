#language: pt
Funcionalidade: Filtrar as requisições
Como um administrador
Eu quero filtrar as requisições
Para que eu possa ter uma visão mais personalizada


  Cenário: Filtrar as requisições Em Espera
    Dado que eu sou um usuário administrador logado
    E que eu tenho uma requisição com estado "Em Espera" e id "25"
    E que eu estou na página de visualização de requisições
    Quando eu seleciono "Em Espera" em "Filtrar por"
    E eu pressiono "OK"
    Então eu devo estar na página de filtragem de requisições
    E eu devo ver a tabela "requisicoes" com
      | Estado | Protocolo | Solicitante | Cargo     | Email          | Data              | Tipo | Referência |
      | Espera | ID        | Fulano      | Professor | fulano@uenf.br | Daqui a dois dias | Ida  | -          |

  Cenário: Filtrar as requisições Rejeitadas
    Dado que eu sou um usuário administrador logado
    E que eu tenho uma requisição com estado "Rejeitada" e id "25"
    E que eu estou na página de visualização de requisições
    Quando eu seleciono "Rejeitada" em "Filtrar por"
    E eu pressiono "OK"
    Então eu devo estar na página de filtragem de requisições
    E eu devo ver a tabela "requisicoes" com
      | Estado    | Protocolo | Solicitante | Cargo     | Email          | Data              | Tipo | Referência |
      | Rejeitada | ID        | Fulano      | Professor | fulano@uenf.br | Daqui a dois dias | Ida  | -          |


  Cenário: Filtrar as requisições Canceladas pelo Professor
    Dado que eu sou um usuário administrador logado
    E que eu tenho uma requisição com estado "Cancelada pelo Professor" e id "25"
    E que eu estou na página de visualização de requisições
    Quando eu seleciono "Cancelada pelo Professor" em "Filtrar por"
    E eu pressiono "OK"
    Então eu devo estar na página de filtragem de requisições
    E eu devo ver a tabela "requisicoes" com
      | Estado    | Protocolo | Solicitante | Cargo     | Email          | Data              | Tipo | Referência |
      | Cancelado | ID        | Fulano      | Professor | fulano@uenf.br | Daqui a dois dias | Ida  | -          |



  Cenário: Filtrar as requisições Canceladas pelo Sistema
    Dado que eu sou um usuário administrador logado
    E que eu tenho uma requisição com estado "Cancelada pelo Sistema" e id "25"
    E que eu estou na página de visualização de requisições
    Quando eu seleciono "Cancelada pelo Sistema" em "Filtrar por"
    E eu pressiono "OK"
    Então eu devo estar na página de filtragem de requisições
    E eu devo ver a tabela "requisicoes" com
      | Estado    | Protocolo | Solicitante | Cargo     | Email          | Data              | Tipo | Referência |
      | Cancelado | ID        | Fulano      | Professor | fulano@uenf.br | Daqui a dois dias | Ida  | -          |


  Cenário: Filtrar as requisições Aceitas
    Dado que eu sou um usuário administrador logado
    E que eu tenho uma requisição com estado "Aceita" e id "25"
    E que eu tenho uma viagem com o estado "Aguardando"
    E que a requisição esteja ligada à viagem
    E que eu estou na página de visualização de requisições
    Quando eu seleciono "Aceita" em "Filtrar por"
    E eu pressiono "OK"
    Então eu devo estar na página de filtragem de requisições
    E eu devo ver a tabela "requisicoes" com
      | Estado | Protocolo | Solicitante | Cargo     | Email          | Data              | Tipo | Referência |
      | Aceita | ID        | Fulano      | Professor | fulano@uenf.br | Daqui a dois dias | Ida  | -          |

