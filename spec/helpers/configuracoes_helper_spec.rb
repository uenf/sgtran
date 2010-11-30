require 'spec_helper'

describe ConfiguracoesHelper do

  #Delete this example and add some real ones or delete this file
  it "is included in the helper object" do
    included_modules = (class << helper; self; end).send :included_modules
    included_modules.should include(ConfiguracoesHelper)
  end

  it 'mostrar os campos dos formulários de acordo com o path' do
    helper.mostrar_formulario("/configuracoes/formulario").should == "formulario_requisicao"
    helper.mostrar_formulario("/configuracoes/instituicao").should == "formulario_instituicao"
  end

end

