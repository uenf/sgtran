def logout
  visit sair_path
end

def login(username, senha)
  visit admin_path
  fill_in("Login", :with => username)
  fill_in("Senha", :with => senha)
  click_button("Entrar")
end

def tipo_usuario tipo
  tipos = {'administrador' => :admin, 'visitante' => :visit}
  tipos[tipo]
end

Dado /^que eu sou um usuário (.+) logado$/ do |tipo|
  tipo = tipo_usuario(tipo)
  usuario = Factory.create :usuario,
                             :login => "admin",
                             :password => "admin",
                             :password_confirmation => "admin"
  usuario.has_role! tipo
  login("admin", "admin")
end

Dado /^que eu tenho um usuário (.+) com login "([^"]*)" e senha "([^"]*)"$/ do |tipo, login, senha|
  tipo = tipo_usuario(tipo)
  usuario = Factory.create :usuario,
                             :login => login,
                             :password => senha,
                             :password_confirmation => senha
  usuario.has_role! tipo
end

Dado /^que eu tenho uma requisição com solicitante "([^\"]*)"$/ do |solicitante|
  centro = Factory.create :centro
  solicitante = Factory.create :solicitante,
                               :nome => solicitante,
                               :centro_id => centro.id
  categoria_de_veiculo = Factory.create :categoria_de_veiculo
  objetivo_de_reserva = Factory.create :objetivo_de_reserva
  Factory.create :requisicao,
                 :solicitante_id => solicitante.id,
                 :categoria_de_veiculo_id => categoria_de_veiculo.id,
                 :objetivo_de_reserva_id => objetivo_de_reserva.id
end

Dado /^que eu não estou logado$/ do
  logout
end

