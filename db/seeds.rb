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
      Veiculo.create!(:modelo => modelo,
                      :marca => marca,
                      :placa => placa,
                      :numero_de_ordem => ordem,
                      :renavam => renavam,
                      :ano => ano,
                      :cor => cor,
                      :categoria_de_veiculo_id => CategoriaDeVeiculo.find_by_nome(categoria).id,
                      :combustivel_ids => combustivel_ids)
    end
  end
end

Motorista.delete_all
open("#{Rails.root}/db/seeds_files/motoristas_seed.txt") do |motoristas|
  motoristas.read.each_line do |motorista|
    if motorista != "\n"
      nome, matricula = motorista.chomp.split("|")
      Motorista.create!(:nome_do_motorista => nome,
                        :matricula => matricula,
                        :telefone_do_motorista => "1")
    end
  end
end

Solicitante.delete_all
open("#{Rails.root}/db/seeds_files/solicitantes_seed.txt") do |solicitantes|
  solicitantes.read.each do |s|
    if s != "\n"
      nome, email, matricula, cargo = s.chomp.split("|")
      Solicitante.create!(:nome => nome,
                          :email => email,
                          :matricula => matricula,
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

Requisicao.delete_all
open("#{Rails.root}/db/seeds_files/requisicoes_seed.txt") do |requisicoes|
  requisicoes.read.each do |r|
    if r != "\n"
      sol, categoria_veiculo, cargo, telefone, celular, laboratorio, predio, andar, sala, objetivo, outros, passageiros, roteiro, observacao = r.chomp.split("|")
      data = Date.tomorrow.tomorrow
      solicitante = Solicitante.find_by_nome(sol)
      categoria_de_veiculo = CategoriaDeVeiculo.find_by_nome(categoria_veiculo)
      Requisicao.create!(:solicitante_id => solicitante.id,
                          :categoria_de_veiculo_id => categoria_de_veiculo.id,
                          :cargo_ou_funcao => cargo,
                          :telefone_ou_ramal => telefone,
                          :celular => celular,
                          :laboratorio_ou_setor => laboratorio,
                          :predio => predio,
                          :andar => andar,
                          :sala => sala,
                          :data_de_reserva => data,
                          :objetivo_da_reserva => objetivo,
                          :outros => outros,
                          :nome_telefone_passageiros => passageiros,
                          :roteiro_da_agenda => roteiro,
                          :observacao => observacao)
    end
  end
end

