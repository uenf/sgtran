class CreateSolicitantes < ActiveRecord::Migration
  def self.up
    create_table :solicitantes do |t|
      t.references :centro
      t.string :nome
      t.string :email
      t.string :cargo
      t.string :matricula
      t.string :telefone_ou_ramal
      t.string :laboratorio_ou_setor

      t.timestamps
    end
  end

  def self.down
    drop_table :solicitantes
  end
end

