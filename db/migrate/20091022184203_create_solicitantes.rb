class CreateSolicitantes < ActiveRecord::Migration
  def self.up
    create_table :solicitantes do |t|
      t.references :predio
      t.string :nome
      t.string :email
      t.string :cargo_ou_funcao
      t.string :matricula
      t.string :telefone_ou_ramal
      t.string :laboratorio_ou_setor
      t.string :andar
      t.string :sala

      t.timestamps
    end
  end

  def self.down
    drop_table :solicitantes
  end
end

