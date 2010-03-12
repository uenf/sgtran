class Veiculo < ActiveRecord::Base
  has_one :categoria_de_veiculo
  has_and_belongs_to_many :combustiveis
  has_many :viagens

  validates_presence_of :marca, :modelo, :cor, :ano, :placa, :numero_de_ordem, :renavam
  validate :validar_categoria_de_veiculo, :validar_combustiveis

  def itens_da_view
    return  CategoriaDeVeiculo.find(self.categoria_de_veiculo_id).nome + " - " +
      self.modelo + " - " + self.placa
  end

  protected
  def validar_categoria_de_veiculo
    if self.categoria_de_veiculo_id == nil
      errors.add(:categoria_de_veiculo, 'não selecionada')
    end
  end

  protected
  def validar_combustiveis
    if self.combustivel_ids.empty?
      errors.add(:combustiveis, 'não selecionados')
    end
  end

  def self.ocupados_entre_datas_e_com_categoria(data_partida, data_chegada, categoria_de_veiculo_da_requisicao_id)
    data_partida = data_partida.to_date
    data_chegada = data_chegada.to_date
    veiculos = Veiculo.all
    veiculos_ocupados = []

    veiculos.each do |veiculo|

      viagens = Viagem.find_all_by_veiculo_id(veiculo.id)

      if not viagens.empty?
        viagens.each do |viagem|

          categoria_de_veiculo = CategoriaDeVeiculo.find(veiculo.categoria_de_veiculo_id)

          if (data_partida >= viagem.data_partida and data_partida <= viagem.data_chegada) or
           (data_chegada >= viagem.data_partida and data_chegada <= viagem.data_chegada)

            categoria_de_veiculo.id == categoria_de_veiculo_da_requisicao_id ? marcador = "* " : marcador = ""

            veiculos_ocupados << [marcador + categoria_de_veiculo.nome + " - " + veiculo.modelo + " - " + veiculo.placa,
                                  veiculo.id]
          end
        end
      end
    end
    return veiculos_ocupados
  end

  def self.desocupados_entre_datas_e_com_categoria(data_partida, data_chegada, categoria_de_veiculo_da_requisicao_id)
    data_partida = data_partida.to_date
    data_chegada = data_chegada.to_date
    veiculos = Veiculo.all
    veiculos_desocupados = []

    veiculos.each do |veiculo|

      categoria_de_veiculo = CategoriaDeVeiculo.find(veiculo.categoria_de_veiculo_id)
      categoria_de_veiculo.id == categoria_de_veiculo_da_requisicao_id ? marcador = "* " : marcador = ""
      viagens = Viagem.find_all_by_veiculo_id(veiculo.id)

      if not viagens.empty?
        viagens.each do |viagem|
          if not (data_partida >= viagem.data_partida and data_partida <= viagem.data_chegada) or
           not (data_chegada >= viagem.data_partida and data_chegada <= viagem.data_chegada)

            veiculos_desocupados << [marcador + categoria_de_veiculo.nome + " - " + veiculo.modelo + " - " + veiculo.placa,
                                     veiculo.id]
          end
        end
      else
        veiculos_desocupados << [marcador + categoria_de_veiculo.nome + " - " + veiculo.modelo + " - " + veiculo.placa,
                                 veiculo.id]
      end
    end
    return veiculos_desocupados
  end
end

