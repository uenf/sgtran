class CreateSolicitantes < ActiveRecord::Migration
  def self.up
    create_table :solicitantes do |t|
      t.string :nome
      t.string :email
      t.string :matricula
      t.string :cargo

      t.timestamps
    end
  end

  def self.down
    drop_table :solicitantes
  end
end

