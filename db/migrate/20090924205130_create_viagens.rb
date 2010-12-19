class CreateViagens < ActiveRecord::Migration
  def self.up
    create_table :viagens do |t|
      t.references :veiculo
      t.date :data_partida
      t.date :data_chegada
      t.time :horario_partida
      t.string :estado, :default => Viagem::AGUARDANDO
      t.references :motivo

      t.timestamps
    end

  end

  def self.down
    drop_table :viagens
  end
end

