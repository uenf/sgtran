require 'spec_helper'

describe Relatorio do

  it 'deve ter uma valor válido para ano' do
    relatorio = Relatorio.new :ano => '2010'
    relatorio.should be_valid

    relatorio = Relatorio.new :ano => '10'
    relatorio.should be_invalid

    relatorio = Relatorio.new :ano => ''
    relatorio.should be_invalid
  end

  # Essas testes, são para quando puder definir um interfalo de tempo
  # para o relatório. Por enquanto é apenas anual.

  #it 'deve ter uma data de inicio válida' do
  #  relatorio = Relatorio.new :data_inicial => '19/05/2010'.to_date,
  #                            :data_final => '22/05/2010'.to_date
  #  relatorio.should be_valid

  #  relatorio.data_inicial = '39/05/2010'
  #  relatorio.should be_invalid

  #  relatorio.data_inicial = ''
  #  relatorio.should be_invalid
  #end

  #it 'deve ter uma data de fim válida' do
  #  relatorio = Relatorio.new :data_inicial => '19/05/2010'.to_date,
  #                            :data_final => '22/05/2010'.to_date
  #  relatorio.should be_valid

  #  relatorio.data_final = '39/05/2010'
  #  relatorio.should be_invalid

  #  relatorio.data_final = ''
  #  relatorio.should be_invalid
  #end

  #it 'deve ter uma data final maior ou igual a data inicial' do
  #  relatorio = Relatorio.new :data_inicial => '19/05/2010',
  #                            :data_final => '22/05/2010'
  #  relatorio.should be_valid

  #  relatorio.data_final = "12/04/2010"
  #  relatorio.should be_invalid
  #end

end

