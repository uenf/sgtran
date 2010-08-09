module BdtsHelper

  def estado_local_origem
    requisicao = Requisicao.find @id
    if requisicao.local_origem_id
      local_origem = Cidade.find requisicao.local_origem_id
      local_origem.estado_id
    else
      ""
    end
  end

  def estado_local_destino
    requisicao = Requisicao.find @id
    if requisicao.local_destino_id
      local_destino = Cidade.find requisicao.local_destino_id
      local_destino.estado_id
    else
      ""
    end
  end

  def cidade_local_origem
    requisicao = Requisicao.find @id
    requisicao.local_origem_id
  end

  def cidade_local_destino
    requisicao = Requisicao.find @id
    requisicao.local_destino_id
  end

  def cidades_origem
    requisicao = Requisicao.find @id
    if requisicao.local_origem_id
      local_origem = Cidade.find requisicao.local_origem_id
      Cidade.find_all_by_estado_id(local_origem.estado_id)
    else
      []
    end
  end

  def cidades_destino
    requisicao = Requisicao.find @id
    if requisicao.local_destino_id
      local_destino = Cidade.find requisicao.local_destino_id
      Cidade.find_all_by_estado_id(local_destino.estado_id)
    else
      []
    end
  end

end

