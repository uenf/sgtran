class Veiculo < ActiveRecord::Base
  has_one :categoria_de_veiculo
  has_and_belongs_to_many :combustiveis

  validate :validar_categoria_de_veiculo, :validar_combustiveis

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

  validates_presence_of :marca, :modelo, :cor, :ano, :placa, :numero_de_ordem, :renavam
end

