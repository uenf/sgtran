class CriarJoinViagensMotoristas < ActiveRecord::Migration
  def self.up
    create_table :viagens_motoristas, :id => false do |t|
      t.references :motorista
      t.references :viagem
    end

    execute <<-SQL
      INSERT INTO viagens_motoristas (motorista_id,  viagem_id)
        (SELECT motorista_id, id FROM viagens)
    SQL

    execute <<-SQL
      ALTER TABLE viagens DROP FOREIGN KEY fk_viagem_motorista
    SQL

    execute <<-SQL
      ALTER TABLE viagens DROP COLUMN motorista_id
    SQL

  end

  def self.down
    drop_table :viagens_motoristas
  end
end

