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

