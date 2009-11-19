# language: pt

Funcionalidade: Garantir ordem e visualização das requisições

    Como um administrador
    Eu quero visualizar apenas as requisições em espera, organizadas pela ordem de chegada
    Para que não haja injustiça no momento de aceitar as requisições

    Cenário: View de requisições
      Dado que eu tenha 3 requisições em espera
      E que eu estou na página de visualização de requisições
      Então eu devo ver a tabela "requisicoes" com
        | Estado | Protocolo | Solicitante | Cargo     | Email          | Telefone | Data              | Veículo                           | Objetivo         | Tipo | Referência |
        | Espera | 1         | fulano 1    | Professor | fulano@uenf.br | 22222    | Daqui a dois dias | Micro-ônibus - até 32 passageiros | gasvchgsvchjsvdc | Ida  |     -      |
        | Espera | 2         | fulano 2    | Professor | fulano@uenf.br | 22222    | Daqui a dois dias | Micro-ônibus - até 32 passageiros | gasvchgsvchjsvdc | Ida  |     -      |
        | Espera | 3         | fulano 3    | Professor | fulano@uenf.br | 22222    | Daqui a dois dias | Micro-ônibus - até 32 passageiros | gasvchgsvchjsvdc | Ida  |     -      |

      Quando eu aceito a requisição 2

      E eu vou para a "página de visualização de requisições"
      Então eu devo ver a tabela "requisicoes" com
        | Estado | Protocolo | Solicitante | Cargo     | Email          | Telefone | Data              | Veículo                           | Objetivo         | Tipo | Referência |
        | Espera | 1         | fulano 1    | Professor | fulano@uenf.br | 22222    | Daqui a dois dias | Micro-ônibus - até 32 passageiros | gasvchgsvchjsvdc | Ida  |     -      |
        | Espera | 3         | fulano 3    | Professor | fulano@uenf.br | 22222    | Daqui a dois dias | Micro-ônibus - até 32 passageiros | gasvchgsvchjsvdc | Ida  |     -      |

