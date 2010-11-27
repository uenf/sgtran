# Levantamentos para relatórios:

## Km por centro (ver com Ailton como resolver *)

  + bdt tem a quilometragem
  + bdt está ligado a viagem
  + viagem está ligada a UMA OU MAIS* requisições
  + requisição está ligada ao solicitante
  + solicitante tem o centro

  * Como fazer nesse caso, já que a viagem atende a mais de um centro? Como
    dividir a quilometragem da viagem?


## Km percorridos em um determinado período

  + bdt tem datas de partida e chegada
  + bdt tem a quilometragem


## Km percorridos por motorista em um determinado período

  + bdt tem datas de partida e chegada
  + bdt tem a quilometragem
  + bdt está ligado a viagem
  + viagem tem motorista


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
