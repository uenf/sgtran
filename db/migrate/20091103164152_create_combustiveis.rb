class CreateCombustiveis < ActiveRecord::Migration
  def self.up
    create_table :combustiveis do |t|
      t.string :nome

      t.timestamps
    end

    create_table :combustiveis_veiculos, :id => false do |t|
      t.references :combustivel, :veiculo

      t.timestamps
    end

  end

  def self.down
    drop_table :combustiveis_veiculos
    drop_table :combustiveis
  end
end

