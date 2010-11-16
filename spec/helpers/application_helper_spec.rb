require 'spec_helper'

describe ApplicationHelper do

  it 'deve retornar o nome por extenso da permissão do usuario' do
    helper.to_permissao(['admin','visit']).should == ["Administrador", "Visitante"]
  end

end

