Before do
  username = "sgtran"
  senha = "teste"
  usuario = Factory.create :usuario, :login => username, :password => senha, :password_confirmation => senha
  usuario.has_role! :admin
  login(username, senha)
end

def logout
  visit sair_path
end

def login(username, senha)
  visit admin_path
  fill_in("Login", :with => username)
  fill_in("Senha", :with => senha)
  click_button("Entrar")
end



Dado /^que eu tenho uma requisição com solicitante "([^\"]*)"$/ do |solicitante|
  solicitante = Factory.create :solicitante, :nome => solicitante
  categoria_de_veiculo = Factory.create :categoria_de_veiculo
  Factory.create :requisicao, :solicitante_id => solicitante.id, :categoria_de_veiculo_id => categoria_de_veiculo.id
end

Dado /^que eu não estou logado$/ do
  logout
end

Dado /^que eu estou logado$/ do

end

