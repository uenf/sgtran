Dado /^que eu tenho um estado$/ do
  @estado = Factory.create :estado
end

Dado /^que eu tenho o estado com a sigla "([^"]*)"$/ do |sigla|
  @estado ||= Factory.create :estado, :sigla => sigla
end

Então /^o estado deve estar inativo$/ do
  @estado = Estado.all.first
  @estado.status.should == Estado::INATIVO
end

