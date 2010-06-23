# language: pt

Funcionalidade: Adicionar um veículo

Como um administrador
Eu quero adicionar um novo veículo
Para que eu possa utiliza-lo no sistema

  Esquema do Cenário: Adicionar veículo
    Dado que eu tenho o combustível "Gasolina"
    E que eu tenho o combustível "Alcool"
    E que eu tenha a categoria de veículo "Automóvel até 4 passageiros"
    E que eu tenho o prefixo "Locado"
    E que eu estou na página de adição de veículo
    Quando eu preencho "Marca" com "<Marca>"
    E eu preencho "Modelo" com "<Modelo>"
    E eu preencho "Cor" com "<Cor>"
    E eu preencho "Ano" com "<Ano>"
    E eu <Combustivel1> "Gasolina"
    E eu <Combustivel2> "Alcool"
    E eu seleciono "<Categoria>" em "Categoria"
    E eu preencho "Placa" com "<Placa>"
    E eu preencho "Número de ordem" com "<Ordem>"
    E eu preencho "Renavam" com "<Renavam>"
    E eu seleciono "<Prefixo>" em "Prefixo"
    E eu pressiono "Criar Veículo"
    Então eu devo ver "<Sentença>"

    Exemplos:(Veiculo criado com sucesso)
    | Marca | Modelo | Cor  | Ano  | Combustivel1 | Combustivel2 | Categoria                   | Placa    | Ordem  | Renavam | Prefixo              | Sentença                       |
    | Fiat  | Uno    | Azul | 2008 | marco        | marco        | Automóvel até 4 passageiros | LAC-4583 | 145623 | 7961313 | Locado               | Veículo cadastrado com sucesso |


    Exemplos:(Veiculo não criado)

    | Marca | Modelo | Cor  | Ano  | Combustivel1 | Combustivel2 | Categoria                   | Placa    | Ordem  | Renavam | Prefixo              | Sentença                             |
    |       | Uno    | Azul | 2008 | marco        | marco        | Automóvel até 4 passageiros | LAC-4583 | 145623 | 7961313 | Locado               | Marca não pode ser vazio             |
    | Fiat  |        | Azul | 2008 | marco        | marco        | Automóvel até 4 passageiros | LAC-4583 | 145623 | 7961313 | Locado               | Modelo não pode ser vazio            |
    | Fiat  | Uno    |      | 2008 | marco        | marco        | Automóvel até 4 passageiros | LAC-4583 | 145623 | 7961313 | Locado               | Cor não pode ser vazio               |
    | Fiat  | Uno    | Azul |      | marco        | marco        | Automóvel até 4 passageiros | LAC-4583 | 145623 | 7961313 | Locado               | Ano não pode ser vazio               |
    | Fiat  | Uno    | Azul | 2008 | não marco    | não marco    | Automóvel até 4 passageiros | LAC-4583 | 145623 | 7961313 | Locado               | Combustiveis não selecionados        |
    | Fiat  | Uno    | Azul | 2008 | marco        | marco        | Selecione uma categoria     | LAC-4583 | 145623 | 7961313 | Locado               | Categoria de veiculo não selecionada |
    | Fiat  | Uno    | Azul | 2008 | marco        | marco        | Automóvel até 4 passageiros |          | 145623 | 7961313 | Locado               | Placa não pode ser vazio             |
    | Fiat  | Uno    | Azul | 2008 | marco        | marco        | Automóvel até 4 passageiros | LAC-4583 |        | 7961313 | Locado               | Numero de ordem não pode ser vazio   |
    | Fiat  | Uno    | Azul | 2008 | marco        | marco        | Automóvel até 4 passageiros | LAC-4583 | 145623 |         | Locado               | Renavam não pode ser vazio           |
    | Fiat  | Uno    | Azul | 2008 | marco        | marco        | Automóvel até 4 passageiros | LAC-4583 | 145623 | 7961313 | Selecione um prefixo | Prefixo não selecionado              |


  Esquema do Cenário: Ativar/Desativar um veículo pela página de edição
    Dado que eu tenha um veículo da categoria "4 Passageiros", modelo "Gol" e placa "ABC-1234"
    E que o veículo esteja "<Estado do Veículo>"
    E que eu estou na página de edição do veículo
    Quando eu seleciono "<Estado desejado>" em "Estado"
    E eu pressiono "Atualizar"
    Então eu devo ver "Estado: <Estado desejado>"

  Exemplos:
  | Estado do Veículo | Estado desejado |
  | Ativo             | Inativo         |
  | Inativo           | Ativo           |

