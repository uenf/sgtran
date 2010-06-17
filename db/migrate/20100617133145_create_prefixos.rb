class CreatePrefixos < ActiveRecord::Migration
  def self.up
    create_table :prefixos do |t|
      t.string :nome
      t.string :estado, :default => Centro::ATIVO

      t.timestamps
    end
  end

  def self.down
    drop_table :prefixos
  end
end

