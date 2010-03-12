class CreateObjetivosDeReserva < ActiveRecord::Migration
  def self.up
    create_table :objetivos_de_reserva do |t|
      t.string :texto

      t.timestamps
    end
  end

  def self.down
    drop_table :objetivos_de_reserva
  end
end

