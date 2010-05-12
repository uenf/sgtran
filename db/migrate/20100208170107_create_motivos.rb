class CreateMotivos < ActiveRecord::Migration
  def self.up
    create_table :motivos do |t|
      t.string :descricao
      t.string :estado, :default => Motivo::ATIVO

      t.timestamps
    end
  end

  def self.down
    drop_table :motivos
  end
end
