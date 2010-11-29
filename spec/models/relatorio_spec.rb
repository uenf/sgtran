require 'spec_helper'

describe Relatorio do

  it 'deve ter uma data de inicio válida' do
    relatorio = Relatorio.new :data_inicio => '19/05/20010',
                              :data_fim => '22/05/20010'
    relatorio.should be_valid

    relatorio.data_inicio = '39/05/20010'
    relatorio.should be_invalid

    relatorio.data_inicio = ''
    relatorio.should be_invalid
  end


end

