class CreateMotoristas < ActiveRecord::Migration
  def self.up
    create_table :motoristas do |t|

      t.string  :matricula
      t.string  :nome
      t.string  :telefone
      t.string  :habilitacao
      t.date    :vencimento_habilitacao
      t.string  :estado, :default => "Ativo"
      t.boolean :avisado, :default => true

      t.timestamps
    end

  end

  def self.down
    drop_table :motoristas
  end
end

