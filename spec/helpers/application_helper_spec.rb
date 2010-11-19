require 'spec_helper'

describe ApplicationHelper do

  it 'deve retornar o nome por extenso da permissão do usuario' do
    helper.to_permissao(['admin','visit']).should == ["Administrador", "Visitante"]
  end

  it 'deve retornar se é visível ou não dado um objeto' do
    helper.visibilidade(nil).should == 'invisivel'
    helper.visibilidade('anything').should == 'visivel'
  end

  it 'deve retornar se é selecionado ou não dado um objeto' do
    helper.selecao(nil).should == nil
    helper.selecao('anything').should == 'selected="selected"'
  end

end

