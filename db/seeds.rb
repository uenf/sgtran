Combustivel.delete_all
open("#{Rails.root}/db/seeds_files/combustiveis_seed.txt") do |combustiveis|
  combustiveis.read.each_line do |combustivel|
    if combustivel != "\n"
      combustivel = combustivel.chomp
      Combustivel.create!(:nome => combustivel)
    end
  end
end

CategoriaDeVeiculo.delete_all
open("#{Rails.root}/db/seeds_files/categoria_de_veiculos_seed.txt") do |categorias|
  categorias.read.each_line do |categoria|
    if categoria != "\n"
      categoria = categoria.chomp
      CategoriaDeVeiculo.create!(:nome => categoria)
    end
  end
end

Prefixo.delete_all
Prefixo.create!(:nome => "Locado")

Veiculo.delete_all
open("#{Rails.root}/db/seeds_files/veiculos_seed.txt") do |veiculos|
  veiculos.read.each_line do |veiculo|
    if veiculo != "\n"
      combustivel_ids = []
      modelo, marca, placa, ordem, renavam, ano, combustiveis, cor, categoria,  = veiculo.chomp.split("|")
      combustiveis = combustiveis.split(",")
      combustiveis.each do |c|
        combustivel_ids << Combustivel.find_by_nome(c).id
      end
      prefixo = Prefixo.all.first
      Veiculo.create!(:modelo => modelo,
                      :marca => marca,
                      :placa => placa,
                      :numero_de_ordem => ordem,
                      :renavam => renavam,
                      :ano => ano,
                      :cor => cor,
                      :categoria_de_veiculo_id => CategoriaDeVeiculo.find_by_nome(categoria).id,
                      :combustivel_ids => combustivel_ids,
                      :prefixo_id => prefixo.id)
    end
  end
end

Motorista.delete_all
open("#{Rails.root}/db/seeds_files/motoristas_seed.txt") do |motoristas|
  motoristas.read.each_line do |motorista|
    if motorista != "\n"
      nome, matricula = motorista.chomp.split("|")
      Motorista.create!(:nome => nome,
                        :matricula => matricula,
                        :telefone => "1")
    end
  end
end

Centro.delete_all
open("#{Rails.root}/db/seeds_files/centros_seed.txt") do |centros|
  centros.read.each_line do |centro|
    if centro != "\n"
      nome = centro.chomp
      Centro.create!(:nome => nome)
    end
  end
end

Solicitante.delete_all
open("#{Rails.root}/db/seeds_files/solicitantes_seed.txt") do |solicitantes|
  solicitantes.read.each do |s|
    if s != "\n"
      matricula, nome, email, lab_ou_setor, centro, ramal, cargo = s.chomp.split("|")
      Solicitante.create!(:matricula => matricula,
                          :nome => nome,
                          :email => email,
                          :laboratorio_ou_setor => lab_ou_setor,
                          :centro_id => Centro.find_by_nome(centro).id,
                          :telefone_ou_ramal => ramal,
                          :cargo => cargo)
    end
  end
end

Usuario.delete_all
open("#{Rails.root}/db/seeds_files/usuarios_seed.txt") do |usuarios|
  usuarios.read.each do |u|
    if u != "\n"
      nome, email, login, password, role = u.chomp.split("|")
      @usuario = Usuario.new({:nome => nome, :email => email, :login => login, :password => password, :password_confirmation => password})
      @usuario.save
      @usuario.has_role! role
    end
  end
end

ObjetivoDeReserva.delete_all
open("#{Rails.root}/db/seeds_files/objetivos_de_reserva.txt") do |objetivos|
  objetivos.read.each_line do |objetivo|
    if objetivo != "\n"
      texto = objetivo.chomp
      ObjetivoDeReserva.create!(:texto => texto)
    end
  end
end

Motivo.delete_all
open("#{Rails.root}/db/seeds_files/motivos_seed.txt") do |motivos|
  motivos.read.each_line do |motivo|
    if motivo != "\n"
      descricao = motivo.chomp
      Motivo.create!(:descricao => descricao)
    end
  end
end
Viagem.delete_all

Estado.delete_all
open("#{Rails.root}/db/seeds_files/estados_seed.txt") do |estados|
  estados.read.each_line do |estado|
    if estado != "\n"
      sigla, nome = estado.chomp.split("|")
      Estado.create!(:sigla => sigla, :nome => nome)
    end
  end
end

Cidade.delete_all
open("#{Rails.root}/db/seeds_files/cidades_seed.txt") do |cidades|
  cidades.read.each_line do |cidade|
    if cidade != "\n"
      estado_id, nome = cidade.chomp.split("|")
      Cidade.create!(:estado_id => estado_id, :nome => nome)
    end
  end
end

Configuracao.delete_all
Configuracao.create!

