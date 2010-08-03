Dado /^que eu tenho uma cidade$/ do
  estado = Factory.create :estado, :nome => "São Paulo", :sigla => "SP"
  @cidade = Factory.create :cidade, :estado_id => estado.id
end

Dado /^que eu tenho a cidade "([^"]*)" do "([^"]*)"$/ do |nome, sigla|
  if Estado.find_all_by_sigla(sigla).empty?
    estado = Factory.create :estado, :sigla => sigla
  else
    estado = Estado.all.first
  end

  Factory.create :cidade, :nome => nome, :estado_id => estado.id
end

