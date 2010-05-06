#language: pt
Funcionalidade: Filtrar as viagens
Como um administrador
Eu quero filtrar as viagens
Para que eu possa ter uma visão mais personalizada


  Cenário: Filtrar as viagens Aguardando
    Dado que eu tenho uma viagem com o estado "Cancelada"
    E que eu tenho outra viagem com o estado "Cancelada"
    E que eu tenho outra viagem com o estado "Aguardando"
    E que eu estou na página de visualização de viagens
    Quando eu seleciono "Aguardando" em "Filtrar por"
    E eu pressiono "OK"
    Então eu devo estar na página de filtragem de viagens
    E eu devo ver a tabela "viagens" com
      | Estado      | Data de partida   | Data de chegada   | Horário de partida | Solicitantes  | Motorista       | Veículo | Requisição(s) atendida(s) |
      | Aguardando  | Daqui a dois dias | Daqui a dois dias |                    | Fulano        | fulano de tal   |         | ID                        |


  Cenário: Filtrar as viagens Canceladas
    Dado que eu tenho uma viagem com o estado "Aguardando"
    E que eu tenho outra viagem com o estado "Atendida"
    E que eu tenho outra viagem com o estado "Cancelada"
    E que eu estou na página de visualização de viagens
    Quando eu seleciono "Cancelada" em "Filtrar por"
    E eu pressiono "OK"
    Então eu devo estar na página de filtragem de viagens
    E eu devo ver a tabela "viagens" com
      | Estado      | Data de partida   | Data de chegada   | Horário de partida | Solicitantes  | Motorista       | Veículo | Requisição(s) atendida(s) |
      | Cancelada   | Daqui a dois dias | Daqui a dois dias |                    | Fulano        | fulano de tal   |         | ID                        |


  Cenário: Filtrar as viagens Atendidas
    Dado que eu tenho uma viagem com o estado "Aguardando"
    E que eu tenho outra viagem com o estado "Cancelada"
    E que eu tenho outra viagem com o estado "Atendida"
    E que eu estou na página de visualização de viagens
    Quando eu seleciono "Atendida" em "Filtrar por"
    E eu pressiono "OK"
    Então eu devo estar na página de filtragem de viagens
    E eu devo ver a tabela "viagens" com
      | Estado      | Data de partida   | Data de chegada   | Horário de partida  | Solicitantes  | Motorista       | Veículo | Requisição(s) atendida(s) |
      | Atendida    | Daqui a dois dias | Daqui a dois dias |                     | Fulano        | fulano de tal   |         | ID                        |

