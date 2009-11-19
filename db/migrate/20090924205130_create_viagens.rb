class CreateViagens < ActiveRecord::Migration
  def self.up
    create_table :viagens do |t|
      t.references :motorista
      t.date :data_partida
      t.date :data_chegada
      t.time :horario_partida
      t.string :estado, :default => Viagem::AGUARDANDO

      t.timestamps
    end

    execute <<-SQL
      ALTER TABLE viagens
        ADD CONSTRAINT fk_viagem_motorista
        FOREIGN KEY (motorista_id)
        REFERENCES motoristas(id)
    SQL

  end

  def self.down
    drop_table :viagens
  end
end

