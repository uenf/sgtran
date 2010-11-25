class CreateConfiguracoes < ActiveRecord::Migration
  def self.up
    create_table :configuracoes do |t|
      t.string :orgao_utilizador, :default => "Universidade Estadual do Norte Fluminense Darcy Ribeiro"
      t.boolean :formulario_ativo, :default => true

      t.timestamps
    end
    Configuracao.create!
  end

  def self.down
    drop_table :configuracoes
  end
end

