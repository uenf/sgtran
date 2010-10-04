class Veiculo < ActiveRecord::Base

  ATIVO = "Ativo"
  INATIVO = "Inativo"

  belongs_to :categoria_de_veiculo
  has_and_belongs_to_many :combustiveis
  has_many :viagens
  belongs_to :prefixo

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
    Veiculo.find_all_by_status("Ativo").each do |veiculo|
      viagens = Viagem.find(:all,
              :conditions => ["veiculo_id = ? AND estado = ? AND  \
              ((? BETWEEN data_partida AND data_chegada) OR \
              (? BETWEEN data_partida AND data_chegada))",
              veiculo.id,
              'Aguardando',
              data_partida,
              data_chegada])

      viagens.each do |viagem|
        categoria_de_veiculo = CategoriaDeVeiculo.find(veiculo.categoria_de_veiculo_id)
        categoria_de_veiculo.id == categoria_de_veiculo_da_requisicao_id ? marcador = "* " : marcador = ""
        veiculos_ocupados << ["#{marcador}#{veiculo.modelo} - #{veiculo.placa} - #{categoria_de_veiculo.nome}",
                                veiculo.id]
      end
    end
    return veiculos_ocupados.uniq
  end

  def self.desocupados_entre_datas_e_com_categoria(data_partida, data_chegada, categoria_de_veiculo_da_requisicao_id)
    veiculos_ocupados = self.ocupados_entre_datas_e_com_categoria(data_partida, data_chegada, categoria_de_veiculo_da_requisicao_id)
    veiculos_ocupados_ids, veiculos_desocupados = [], []

    veiculos_ocupados.each { |veiculo| veiculos_ocupados_ids << veiculo[1] }
    veiculos_desocupados_ids = Veiculo.find_all_by_status("Ativo").collect(&:id) - veiculos_ocupados_ids

    veiculos_desocupados_ids.each do |veiculo_id|
      veiculo = Veiculo.find(veiculo_id)
      categoria_de_veiculo = CategoriaDeVeiculo.find(veiculo.categoria_de_veiculo_id)
      categoria_de_veiculo.id == categoria_de_veiculo_da_requisicao_id ? marcador = "* " : marcador = ""

      veiculos_desocupados << ["#{marcador}#{veiculo.modelo} - #{veiculo.placa} - #{categoria_de_veiculo.nome}",
                                veiculo.id]
    end

    return veiculos_desocupados
  end
end

