Dado /^que eu tenha um solicitante com e-mail "([^\"]*)", matrícula "([^\"]*)" e prédio "([^\"]*)"$/ do |email, matricula, centro_nome|
  centro = Factory.create :centro, :nome => centro_nome
  @solicitante = Factory.create :solicitante,
                                :email => email,
                                :matricula => matricula,
                                :centro_id => centro.id
end

Dado /^que o solicitante esteja "([^\"]*)"$/ do |status|
  @solicitante.update_attribute(:status, status)
end

