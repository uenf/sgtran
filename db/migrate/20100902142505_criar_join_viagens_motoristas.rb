class CriarJoinViagensMotoristas < ActiveRecord::Migration
  def self.up
    create_table :motoristas_viagens, :id => false do |t|
      t.references :motorista
      t.references :viagem
    end

  end

  def self.down
    drop_table :viagens_motoristas
  end
end

