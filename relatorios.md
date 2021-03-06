# Fontes de prequisa:

## Plotagem de gráficos
  * Gchartrb
    - http://github.com/deepakjois/gchartrb
    - http://badpopcorn.com/blog/2008/09/08/rails-google-charts-gchartrb/
    - http://blog.deepak.jois.name/search/label/gchartrb
    - http://gchartrb.rubyforge.org/
    - http://code.google.com/intl/en/apis/chart/docs/making_charts.html

## Geração do relatório
  *Odf-report
    - https://github.com/sandrods/odf-report

# Levantamentos para relatórios:

## Km por centro (Colocar para cada requisição a quilometragem do BDT)

Dados de entrada: DATA_INICIAL, DATA_FINAL, CENTRO_ID
Saída: quilomentros percorridos entre as datas pelo centro

  + bdt tem a quilometragem
  + bdt está ligado a viagem
  + viagem está ligada a UMA OU MAIS* requisições
  + requisição está ligada ao solicitante
  + solicitante tem o centro


bdts
---------------------
viagem_id
data_partida
data_recolhimento
odometro_partida
odometro_recolhimento

requisicoes
--------------
viagem_id
solicitante_id

solicitantes
-------------
id
centro_id

## Km percorridos em um determinado período

  + bdt tem datas de partida e chegada
  + bdt tem a quilometragem


## Km percorridos por motorista em um determinado período

  + bdt tem datas de partida e chegada
  + bdt tem a quilometragem
  + bdt está ligado a viagem
  + viagem tem motorista

bdts
---------------------
viagem_id
data_partida
data_recolhimento
odometro_partida
odometro_recolhimento


motoristas_viagens
------------------
motorista_id
viagem_id


Dados de entrada: DATA_INICIAL, DATA_FINAL, MOTORISTA_ID
Saída: quilomentros percorridos entre as datas pelo motorista


(A) select viagem_id from motoristas_viagens where motorista_id = MOTORISTA_ID
(Ex) select viagem_id from motoristas_viagens where motorista_id = 1

(B) select viagem_id from bdts where DATA_INICIAL <= data_partida and DATA_FINAL >= data_recolhimento
(Ex) select viagem_id from bdts where '2010-10-10' <= data_partida and '2010-11-09' >= data_recolhimento;


SELECT bdts.viagem_id, bdts.odometro_partida, bdts.odometro_recolhimento FROM bdts, motoristas_viagens where '2010-10-10' <= data_partida AND '2010-11-09' >= data_recolhimento AND motorista_id = 1;
SELECT tabela1.viagem_id, tabela1.odometro_partida, tabela1.odometro_recolhimento FROM (SELECT * from bdts WHERE '2010-10-10' <= data_partida AND '2010-11-09' >= data_recolhimento) as tabela1 JOIN (SELECT viagem_id from motoristas_viagens WHERE motorista_id = 1) as tabela2 ON tabela1.viagem_id = tabela2.viagem_id;
SELECT tabela1.viagem_id, tabela1.odometro_partida, tabela1.odometro_recolhimento FROM (SELECT * from bdts WHERE '2010-10-10' <= data_partida AND '2010-11-09' >= data_recolhimento) as tabela1 JOIN (SELECT viagem_id from motoristas_viagens WHERE motorista_id = 1) as tabela2 ON tabela1.viagem_id = tabela2.viagem_id;

## Km percorridos por veículo em um determinado período

  + bdt tem datas de partida e chegada
  + bdt tem a quilometragem
  + bdt está ligado a viagem
  + viagem tem veículo


## Status de todas as requisições em um determinado período

  + requisição tem status
  + requisição tem data


## Status das requisições por solicitante em um determinado período

  + requisição tem data
  + requisição está ligada a solicitante


## Status das requisições por centro em um determinado período

  + requisição tem data
  + requisição está ligada a solicitante
  + solicitante tem centro


## Status das requisições por loboratório em um determinado período

  + requisição tem data
  + requisição está ligada a solicitante
  + solicitante tem laboratótio


## Horas trabalhadas por motorista em um determinado período

  + bdt tem horarios de partida e chegada
  + bdt está ligado a viagem
  + viagem está ligada a motorista
