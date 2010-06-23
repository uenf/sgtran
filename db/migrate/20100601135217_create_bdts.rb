class CreateBdts < ActiveRecord::Migration
  def self.up
    create_table :bdts do |t|
      t.datetime :recolhimento
      t.datetime :partida
      t.integer :odometro_recolhimento
      t.integer :odometro_partida
      t.string :objetivo
      t.integer :numero
      t.string :local_origem
      t.string :local_destino

      t.timestamps
    end
  end

  def self.down
    drop_table :bdts
  end
end

