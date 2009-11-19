# language: pt

Funcionalidade: Adicionar um veículo

Como um administrador
Eu quero adicionar um novo veículo
Para que eu possa utiliza-lo no sistema

  Esquema do Cenário: Adicionar veículo
    Dado que eu tenho o combustivel "Gasolina"
    E que eu tenho o combustivel "Alcool"
    E que eu tenho a categoria de veiculo "Automóvel até 4 passageiros"
    E que eu estou na pagina de adição de veículo
    Quando eu preencho "Marca" com "<Marca>"
    E eu preencho "Modelo" com "<Modelo>"
    E eu preencho "Cor" com "<Cor>"
    E eu preencho "Ano" com "<Ano>"
    E eu marco "<Combustivel1>"
    E eu marco "<Combustivel2>"
    E eu seleciono "<Categoria>" em "Categoria"
    E eu preencho "Placa" com "<Placa>"
    E eu preencho "Numero de ordem" com "<Ordem>"
    E eu preencho "Renavam" com "<Renavam>"
    E eu pressiono "Cadastrar"
    Então eu devo ver "<Sentença>"

    Exemplos:(Veiculo criado com sucesso)

    | Marca     | Modelo        | Cor       | Ano   | Combustivel1  | Combustivel2  | Categoria                     | Placa     | Ordem     | Renavam   | Sentença                          |
    | Fiat      | Uno           | Azul      | 2008  | Gasolina      | Alcool        | Automóvel até 4 passageiros   | LAC-4583  | 145623    | 7961313   | Veículo cadastrado com sucesso!   |

