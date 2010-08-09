# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20101022184205) do

  create_table "bdts", :force => true do |t|
    t.date     "data_recolhimento"
    t.time     "horario_recolhimento"
    t.date     "data_partida"
    t.time     "horario_partida"
    t.integer  "odometro_recolhimento"
    t.integer  "odometro_partida"
    t.text     "objetivo"
    t.integer  "numero"
    t.integer  "viagem_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categoria_de_veiculos", :force => true do |t|
    t.string   "nome"
    t.integer  "veiculo_id"
    t.string   "estado",     :default => "Ativo"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "centros", :force => true do |t|
    t.string   "nome"
    t.string   "estado",     :default => "Ativo"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cidades", :force => true do |t|
    t.string   "nome"
    t.integer  "estado_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "combustiveis", :force => true do |t|
    t.string   "nome"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "combustiveis_veiculos", :id => false, :force => true do |t|
    t.integer  "combustivel_id"
    t.integer  "veiculo_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "estados", :force => true do |t|
    t.string   "nome"
    t.string   "sigla"
    t.string   "estado",     :default => "Ativo"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "motivos", :force => true do |t|
    t.string   "descricao"
    t.string   "estado",     :default => "Ativo"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "motoristas", :force => true do |t|
    t.string   "matricula"
    t.string   "nome"
    t.string   "telefone"
    t.string   "habilitacao"
    t.date     "vencimento_habilitacao"
    t.string   "estado",                 :default => "Ativo"
    t.boolean  "avisado",                :default => true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "objetivos_de_reserva", :force => true do |t|
    t.string   "texto"
    t.string   "estado",     :default => "Ativo"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "prefixos", :force => true do |t|
    t.string   "nome"
    t.string   "estado",     :default => "Ativo"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "requisicoes", :force => true do |t|
    t.integer  "solicitante_id"
    t.integer  "viagem_id"
    t.integer  "categoria_de_veiculo_id"
    t.integer  "objetivo_de_reserva_id"
    t.string   "celular"
    t.date     "data_de_reserva"
    t.string   "outros"
    t.text     "nome_telefone_passageiros"
    t.text     "roteiro_da_agenda"
    t.text     "observacao"
    t.integer  "local_origem_id"
    t.integer  "local_destino_id"
    t.string   "estado",                    :default => "Espera"
    t.string   "chave_de_seguranca"
    t.integer  "motivo_id"
    t.string   "motivo_professor"
    t.string   "motivo_observacao"
    t.string   "tipo",                      :default => "Ida"
    t.string   "referencia_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.string   "authorizable_type"
    t.integer  "authorizable_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles_usuarios", :id => false, :force => true do |t|
    t.integer  "usuario_id"
    t.integer  "role_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "solicitantes", :force => true do |t|
    t.integer  "centro_id"
    t.string   "nome"
    t.string   "email"
    t.string   "cargo"
    t.string   "matricula"
    t.string   "telefone_ou_ramal"
    t.string   "laboratorio_ou_setor"
    t.string   "estado",               :default => "Ativo"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "usuario_sessions", :force => true do |t|
    t.string   "login"
    t.string   "password"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "usuarios", :force => true do |t|
    t.string   "nome"
    t.string   "email"
    t.string   "login"
    t.string   "crypted_password"
    t.string   "password_salt"
    t.string   "persistence_token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "veiculos", :force => true do |t|
    t.string   "marca"
    t.string   "modelo"
    t.string   "cor"
    t.string   "ano"
    t.string   "placa"
    t.string   "numero_de_ordem"
    t.string   "renavam"
    t.string   "estado",                  :default => "Ativo"
    t.integer  "categoria_de_veiculo_id"
    t.integer  "prefixo_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "viagens", :force => true do |t|
    t.integer  "motorista_id"
    t.integer  "veiculo_id"
    t.date     "data_partida"
    t.date     "data_chegada"
    t.time     "horario_partida"
    t.string   "estado",          :default => "Aguardando"
    t.integer  "motivo_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "viagens", ["motorista_id"], :name => "fk_viagem_motorista"

end
