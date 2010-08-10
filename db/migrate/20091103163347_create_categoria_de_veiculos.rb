class CreateCategoriaDeVeiculos < ActiveRecord::Migration
  def self.up
    create_table :categoria_de_veiculos do |t|
      t.string :nome
      t.references :veiculo
      t.string :status, :default => CategoriaDeVeiculo::ATIVO

      t.timestamps
    end
  end

  def self.down
    drop_table :categoria_de_veiculos
  end
end

