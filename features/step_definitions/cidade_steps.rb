Dado /^que eu tenho uma cidade$/ do
  estado = Factory.create :estado, :nome => "São Paulo", :sigla => "SP"
  @cidade = Factory.create :cidade, :estado_id => estado.id
end

Dado /^que eu tenho a cidade "([^"]*)" do "([^"]*)"$/ do |nome, sigla|
  estado = Estado.find_by_sigla(sigla)

  unless estado
    estado = Factory.create :estado, :sigla => sigla
  end

  Factory.create :cidade, :nome => nome, :estado_id => estado.id
end

