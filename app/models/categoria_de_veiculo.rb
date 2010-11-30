class CategoriaDeVeiculo < ActiveRecord::Base

  ATIVO = "Ativo"
  INATIVO = "Inativo"

  has_many :veiculos
  has_many :requisicoes

  validates_presence_of :nome

  validate :validar_minimo_maximo

  def validar_minimo_maximo
    if not (self.numero_minimo_dias == 0 and self.numero_minimo_dias)
      if self.numero_minimo_dias > self.numero_maximo_dias
        errors.add(:base, "O número mínimo de dias não pode ser maior do que o número máximo de dias.")
      end
      if self.numero_minimo_dias == self.numero_maximo_dias
        errors.add(:base, "O número mínimo de dias não pode ser igual ao número máximo de dias.")
      end
    end
  end


end

