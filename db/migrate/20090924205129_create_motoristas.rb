class CreateMotoristas < ActiveRecord::Migration
  def self.up
    create_table :motoristas do |t|

      t.string :matricula
      t.string :nome_do_motorista
      t.string :telefone_do_motorista
      t.string :habilitacao
      t.date   :vencimento_habilitacao

      t.timestamps
    end

  end

  def self.down
    drop_table :motoristas
  end
end

