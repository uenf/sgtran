class CreateConfiguracoes < ActiveRecord::Migration
  def self.up
    create_table :configuracoes do |t|
      t.string :orgao_utilizador
      t.boolean :formulario_ativo, :default => true

      t.timestamps
    end
  end

  def self.down
    drop_table :configuracoes
  end
end

