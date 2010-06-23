class CreateVeiculos < ActiveRecord::Migration
  def self.up
    create_table :veiculos do |t|
      t.string :marca
      t.string :modelo
      t.string :cor
      t.string :ano
      t.string :placa
      t.string :numero_de_ordem
      t.string :renavam
      t.string :estado, :default => Veiculo::ATIVO
      t.references :categoria_de_veiculo
      t.references :prefixo

      t.timestamps
    end
  end

  def self.down
    drop_table :veiculos
  end
end

