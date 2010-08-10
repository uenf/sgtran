class CreateCidades < ActiveRecord::Migration
  def self.up
    create_table :cidades do |t|
      t.string :nome
      t.references :estado
      t.string :status

      t.timestamps
    end
  end

  def self.down
    drop_table :cidades
  end
end

