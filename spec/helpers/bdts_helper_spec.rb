require 'spec_helper'

describe BdtsHelper do

  describe "edit helpers para casos válidos" do

    before(:each) do
      @rj = Factory.create :estado, :nome => "Rio de Janeiro" , :sigla => "RJ"
      @es = Factory.create :estado, :nome => "Espírito Santo" , :sigla => "ES"
      @campos = Factory.create :cidade, :nome => "Campos", :estado_id => @rj.id
      @guarapari = Factory.create :cidade, :nome => "Guarapari", :estado_id => @es.id

      categoria_de_veiculo = Factory.create :categoria_de_veiculo
      objetivo = Factory.create :objetivo_de_reserva
      @requisicao = Factory.create :requisicao,
                                   :categoria_de_veiculo_id => categoria_de_veiculo.id,
                                   :objetivo_de_reserva_id => objetivo.id,
                                   :local_origem_id => @campos.id,
                                   :local_destino_id => @guarapari.id

      assigns[:id] = @requisicao.id
    end

    it "deve retornar o id do estado do local de origem da requisição" do
      helper.estado_local_origem.should == @rj.id
    end

    it "deve retornar o id do estado do local de destino da requisição" do
      helper.estado_local_destino.should == @es.id
    end

    it "deve retornar o id da cidade do local de origem da requisição" do
      helper.cidade_local_origem.should == @campos.id
    end

    it "deve retornar o id da cidade do local de destino da requisição" do
      helper.cidade_local_destino.should == @guarapari.id
    end

    it "deve retornar uma lista com as cidades do estado do local de origem da requisição" do
      macae = Factory.create :cidade, :nome => "Macaé", :estado_id => @rj.id
      helper.cidades_origem.should include(@campos, macae)
      helper.cidades_origem.should have(2).cidades
    end

    it "deve retornar uma lista com as cidades do estado do local de destino da requisição" do
      vitoria = Factory.create :cidade, :nome => "Vitória", :estado_id => @es.id
      helper.cidades_destino.should include(@guarapari, vitoria)
      helper.cidades_destino.should have(2).cidades
    end

  end

  describe "edit helpers para casos inválidos" do

    before(:each) do
      categoria_de_veiculo = Factory.create :categoria_de_veiculo
      objetivo = Factory.create :objetivo_de_reserva
      @requisicao = Factory.create :requisicao,
                                   :categoria_de_veiculo_id => categoria_de_veiculo.id,
                                   :objetivo_de_reserva_id => objetivo.id,
                                   :local_origem_id => nil,
                                   :local_destino_id => nil

      assigns[:id] = @requisicao.id
    end

    it "deve retornar um string vazio se a requisição não tiver local de origem" do
      helper.estado_local_origem.should == ""
    end

    it "deve retornar um string vazio se a requisição não tiver local de destino" do
      helper.estado_local_destino.should == ""
    end

    it "deve retornar uma lista vazia se a requisicao não tiver um local de origem" do
      helper.cidades_origem.should == []
      helper.cidades_origem.should have(0).cidades
    end

    it "deve retornar uma lista vazia se a requisicao não tiver um local de destino" do
      helper.cidades_destino.should == []
      helper.cidades_destino.should have(0).cidades
    end

  end

end

