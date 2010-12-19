require 'spec_helper'

describe ApplicationHelper do

  def mock_configuracao(stubs={})
    (@mock_configuracao ||= mock_model(Configuracao).as_null_object).tap do |config|
      config.stub(stubs) unless stubs.empty?
    end
  end

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

  it 'deve retornar uma tag html td com class igual ao status do objeto' do
    motorista = Factory.create :motorista, :status => Motorista::ATIVO
    helper.td_status(motorista).should == '<td class="ativo"></td>'

    solicitante = Factory.create :solicitante, :status => Solicitante::INATIVO
    helper.td_status(solicitante).should == '<td class="inativo"></td>'
  end

  it 'deve retornar uma tag html td clicavel' do
    Motorista.delete_all # limpando a tabela motoristas
    motorista = Factory.create :motorista, :id => 3, :nome => "Hugo Maia"
    path = motorista_path(motorista)
    content = motorista.nome
    helper.td_clickable(path, content).should ==
    "<td onclick=\"location.href=\'/motoristas/3\'\" onmouseover=\"this.style.cursor='pointer'\">Hugo Maia</td>"

    solicitante = Factory.create :solicitante, :id => 5, :nome => "Eduardo Hertz"
    path = solicitante_path(solicitante)
    content = solicitante.nome
    helper.td_clickable(path, content).should ==
    "<td onclick=\"location.href=\'/solicitantes/5\'\" onmouseover=\"this.style.cursor='pointer'\">Eduardo Hertz</td>"
  end

#  it 'deve retornar o objeot da configuração inicial' do
#    helper.stub(Configuracao).and_return(mock_configuracao)
#    helper.configuracoes.should == mock_configuracao
#  end

end

