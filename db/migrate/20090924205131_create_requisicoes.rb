class CreateRequisicoes < ActiveRecord::Migration
  def self.up
    create_table :requisicoes do |t|
      t.references :solicitante
      t.references :viagem
      t.references :categoria_de_veiculo
      t.references :objetivo_de_reserva
      t.string :celular
      t.date :data_de_reserva
      t.text :nome_telefone_passageiros
      t.text :roteiro_da_agenda
      t.text :observacao
      t.integer :local_origem_id
      t.integer :local_destino_id


      t.string :estado, :default => Requisicao::ESPERA

      t.string :chave_de_seguranca
      t.references :motivo
      t.string :motivo_professor
      t.string :motivo_observacao

      t.timestamps
    end

  end

  def self.down
    drop_table :requisicoes
  end
end

