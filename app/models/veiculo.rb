class Veiculo < ActiveRecord::Base

  ATIVO = "Ativo"
  INATIVO = "Inativo"

  has_one :categoria_de_veiculo
  has_and_belongs_to_many :combustiveis
  has_many :viagens
  has_one :prefixo

  validates_presence_of :marca,
                        :modelo,
                        :cor,
                        :ano,
                        :placa,
                        :numero_de_ordem,
                        :renavam

  validate :validar_categoria_de_veiculo, :validar_combustiveis, :validar_prefixo

  def itens_da_view
    return  self.modelo + " - " + self.placa + " - " +
            CategoriaDeVeiculo.find(self.categoria_de_veiculo_id).nome
  end

  def ativo?
    true ? self.status == ATIVO : false
  end

  def validar_categoria_de_veiculo
    if self.categoria_de_veiculo_id == nil
      errors.add(:categoria_de_veiculo, 'não selecionada')
    end
  end

  def validar_prefixo
    if self.prefixo_id == nil
      errors.add(:prefixo, "não selecionado")
    end
  end

  def validar_combustiveis
    if self.combustivel_ids.empty?
      errors.add(:combustiveis, 'não selecionados')
    end
  end

  def formatacao_para_bdt
    "#{self.modelo} - #{self.placa}"
  end

  def self.ocupados_entre_datas_e_com_categoria(data_partida, data_chegada, categoria_de_veiculo_da_requisicao_id)
    veiculos_ocupados = []

    Veiculo.all.each do |veiculo|

      viagens = Viagem.find_all_by_veiculo_id_and_estado(veiculo.id, "Aguardando")

      if not viagens.empty? and veiculo.ativo?
        viagens.each do |viagem|

          categoria_de_veiculo = CategoriaDeVeiculo.find(veiculo.categoria_de_veiculo_id)

          if (data_partida >= viagem.data_partida and data_partida <= viagem.data_chegada) or
           (data_chegada >= viagem.data_partida and data_chegada <= viagem.data_chegada)

            categoria_de_veiculo.id == categoria_de_veiculo_da_requisicao_id ? marcador = "* " : marcador = ""

            veiculos_ocupados << [marcador + veiculo.modelo + " - " + veiculo.placa + " - " + categoria_de_veiculo.nome,
                                  veiculo.id]
          end
        end
      end
    end
    return veiculos_ocupados.uniq
  end

  def self.desocupados_entre_datas_e_com_categoria(data_partida, data_chegada, categoria_de_veiculo_da_requisicao_id)
    veiculos_desocupados = []

    Veiculo.all.each do |veiculo|

      if veiculo.ativo?
        categoria_de_veiculo = CategoriaDeVeiculo.find(veiculo.categoria_de_veiculo_id)
        categoria_de_veiculo.id == categoria_de_veiculo_da_requisicao_id ? marcador = "* " : marcador = ""
        viagens = Viagem.find_all_by_veiculo_id_and_estado(veiculo.id, "Aguardando")

        if not viagens.empty?
          viagens.each do |viagem|
            if not (data_partida >= viagem.data_partida and data_partida <= viagem.data_chegada) and
             not (data_chegada >= viagem.data_partida and data_chegada <= viagem.data_chegada)
              veiculos_desocupados << [marcador + veiculo.modelo + " - " + veiculo.placa + " - " + categoria_de_veiculo.nome,
                                       veiculo.id]
            end
          end
        else
          veiculos_desocupados << [marcador + veiculo.modelo + " - " + veiculo.placa + " - " + categoria_de_veiculo.nome,
                                   veiculo.id]
        end
      end
    end
    return veiculos_desocupados.uniq
  end
end

