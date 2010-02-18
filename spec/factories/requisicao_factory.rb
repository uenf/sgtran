Factory.define :requisicao do |requisicao|

  requisicao.solicitante_id "5"
  requisicao.celular "2020202"
  requisicao.data_de_reserva Date.today + 2.days
  requisicao.categoria_de_veiculo_id nil
  requisicao.objetivo_de_reserva_id nil
  requisicao.outros "vfdsvdfvfdv"
  requisicao.nome_telefone_passageiros "fhjdsvcdsvghsvd"
  requisicao.roteiro_da_agenda "djvsdghvsvdsv"
  requisicao.observacao "bfdbfdbdfbfdbd"
  requisicao.chave_de_seguranca "a6170a5d995e53fe01f9b02f60e3bbc1c2bfcc74"
  requisicao.estado Requisicao::ESPERA
  requisicao.motivo_id nil
  requisicao.tipo "Ida"
  requisicao.referencia_id nil
  requisicao.viagem_id nil

end

