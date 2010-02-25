class CreatePredios < ActiveRecord::Migration
  def self.up
    create_table :predios do |t|
      t.string :nome

      t.timestamps
    end
  end

  def self.down
    drop_table :predios
  end
end
