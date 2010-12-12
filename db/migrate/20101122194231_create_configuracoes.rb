class CreateConfiguracoes < ActiveRecord::Migration
  def self.up
    create_table :configuracoes do |t|
      t.string :orgao_utilizador, :default => "Universidade Estadual do Norte Fluminense Darcy Ribeiro"
      t.string :nome_do_setor, :default => "Assessoria de Transporte"
      t.boolean :formulario_ativo, :default => true
      t.date :data_inicial_proibicao
      t.date :data_final_proibicao
      t.boolean :ano_corrente, :default => true

      t.timestamps
    end
    Configuracao.create!
  end

  def self.down
    drop_table :configuracoes
  end
end

