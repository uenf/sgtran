Dado /^que eu tenha um solicitante com e-mail "([^\"]*)", matrícula "([^\"]*)" e prédio "([^\"]*)"$/ do |email, matricula, centro_nome|
  centro = Factory.create :centro, :nome => centro_nome
  @solicitante = Factory.create :solicitante,
                                :email => email,
                                :matricula => matricula,
                                :centro_id => centro.id
end

Dado /^que o solicitante esteja "([^\"]*)"$/ do |estado|
  @solicitante.estado = Solicitante::ATIVO if estado == Solicitante::ATIVO
  @solicitante.estado = Solicitante::INATIVO if estado == Solicitante::INATIVO
  @solicitante.save
end
