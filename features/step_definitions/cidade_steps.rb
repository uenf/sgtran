Dado /^que eu tenho uma cidade$/ do
  estado = Factory.create :estado, :nome => "São Paulo", :sigla => "SP"
  @cidade = Factory.create :cidade, :estado_id => estado.id
end

