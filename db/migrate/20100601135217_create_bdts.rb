class CreateBdts < ActiveRecord::Migration
  def self.up
    create_table :bdts do |t|
      t.date :data_recolhimento
      t.time :horario_recolhimento
      t.date :data_partida
      t.time :horario_partida
      t.integer :odometro_recolhimento
      t.integer :odometro_partida
      t.text :objetivo
      t.integer :numero
      t.string :local_origem
      t.string :local_destino
      t.references :viagem

      t.timestamps
    end
  end

  def self.down
    drop_table :bdts
  end
end

