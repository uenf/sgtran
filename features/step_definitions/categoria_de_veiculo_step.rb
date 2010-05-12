Dado /^que eu tenha uma categoria de veículo "([^\"]*)"$/ do |nome|
  @categoria_de_veiculo = Factory.create :categoria_de_veiculo, :nome => nome
end

Dado /^que a categoria de veículo esteja "([^\"]*)"$/ do |estado|
  @categoria_de_veiculo.estado = CategoriaDeVeiculo::ATIVO if estado == CategoriaDeVeiculo::ATIVO
  @categoria_de_veiculo.estado = CategoriaDeVeiculo::INATIVO if estado == CategoriaDeVeiculo::INATIVO
  @categoria_de_veiculo.save
end
