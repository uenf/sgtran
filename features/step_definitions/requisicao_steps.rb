Dado /^que eu tenho uma requisição com estado "([^\"]*)"$/ do |estado|
  categoria_de_veiculo = Factory.create :categoria_de_veiculo
  predio = Factory.create :predio
  solicitante = Factory.create :solicitante, :predio_id => predio.id
  motivo = Factory.create :motivo
  objetivo_de_reserva = Factory.create :objetivo_de_reserva
  case estado.to_s
    when "Em Espera" then
      @requisicao = Factory.create :requisicao,
                                          :estado => Requisicao::ESPERA,
                                          :categoria_de_veiculo_id => categoria_de_veiculo.id,
                                          :solicitante_id => solicitante.id,
                                          :objetivo_de_reserva_id => objetivo_de_reserva.id
    when "Rejeitada" then
      @requisicao = Factory.create :requisicao,
                                          :estado => Requisicao::REJEITADA,
                                          :categoria_de_veiculo_id => categoria_de_veiculo.id,
                                          :solicitante_id => solicitante.id,
                                          :motivo_id => motivo.id,
                                          :objetivo_de_reserva_id => objetivo_de_reserva.id
  when "Cancelada pelo Professor" then
      @requisicao = Factory.create :requisicao,
                                          :estado => Requisicao::CANCELADO_PELO_PROFESSOR,
                                          :categoria_de_veiculo_id => categoria_de_veiculo.id,
                                          :solicitante_id => solicitante.id,
                                          :motivo_professor => "Algum motivo",
                                          :objetivo_de_reserva_id => objetivo_de_reserva.id
    when "Cancelada pelo Sistema" then
      @requisicao = Factory.create :requisicao,
                                          :estado => Requisicao::CANCELADO_PELO_SISTEMA,
                                          :categoria_de_veiculo_id => categoria_de_veiculo.id,
                                          :solicitante_id => solicitante.id,
                                          :motivo_id => motivo.id,
                                          :objetivo_de_reserva_id => objetivo_de_reserva.id
    when "Aceita" then
      @requisicao = Factory.create :requisicao,
                                          :estado => Requisicao::ACEITA,
                                          :categoria_de_veiculo_id => categoria_de_veiculo.id,
                                          :solicitante_id => solicitante.id,
                                          :objetivo_de_reserva_id => objetivo_de_reserva.id
  end
end

Dado /^que eu tenho uma viagem com estado "([^\"]*)"$/ do |estado|
  categoria_de_veiculo = Factory.create :categoria_de_veiculo
  predio = Factory.create :predio
  solicitante = Factory.create :solicitante, :predio_id => predio.id
  case estado.to_s
    when "Aguardando" then
      @viagem = Factory.create :viagem, :estado => Viagem::AGUARDANDO
    when "Cancelada" then
      @viagem = Factory.create :viagem, :estado => Viagem::CANCELADA
    when "Atendida" then
      @viagem = Factory.create :viagem, :estado => Viagem::ATENDIDA
  end
end

Dado /^que eu tenho uma requisição de ida com número de protocolo ([^\"]*)$/ do |protocolo|
  categoria_de_veiculo = Factory.create :categoria_de_veiculo
  objetivo_de_reserva = Factory.create :objetivo_de_reserva
  @requisicao_ida = Factory.create :requisicao,
                                   :tipo => "Ida",
                                   :id => protocolo,
                                   :solicitante_id => @solicitante.id,
                                   :categoria_de_veiculo_id => categoria_de_veiculo.id,
                                   :objetivo_de_reserva_id => objetivo_de_reserva.id
end

Dado /^que eu tenho uma requisição de volta com número de protocolo ([^\"]*)$/ do |protocolo|
  categoria_de_veiculo = Factory.create :categoria_de_veiculo
  objetivo_de_reserva = Factory.create :objetivo_de_reserva
  @requisicao_volta = Factory.create :requisicao,
                                     :tipo => "Volta",
                                     :id => protocolo,
                                     :solicitante_id => @solicitante.id,
                                     :categoria_de_veiculo_id => categoria_de_veiculo.id,
                                     :objetivo_de_reserva_id => objetivo_de_reserva.id
  @requisicao_volta.referencia_id = @requisicao_ida.id
  @requisicao_ida.referencia_id = @requisicao_volta.id
  @requisicao_volta.save!
  @requisicao_ida.save!
end

Dado /^que eu tenha um solicitante com e-mail "([^\"]*)", matrícula "([^\"]*)" e prédio "([^\"]*)"$/ do |email, matricula, predio_nome|
  predio = Factory.create :predio, :nome => predio_nome
  @solicitante = Factory.create :solicitante,
                                :email => email,
                                :matricula => matricula,
                                :predio_id => predio.id
end

Dado /^que eu estou logado com o login "([^\"]*)" e a senha "([^\"]*)"$/ do |login, senha|
  usuario = Factory.create :usuario, :login => login, :password => senha, :password_confirmation => senha
  Factory.create :usuario_session, :login => usuario.login, :senha => usuario.password
end

Dado /^que eu tenha uma viagem$/ do
  categoria_de_veiculo = Factory.create :categoria_de_veiculo
  objetivo_de_reserva = Factory.create :objetivo_de_reserva
  combustivel = Factory.create :combustivel
  veiculo = Factory.create :veiculo,
                  :categoria_de_veiculo_id => categoria_de_veiculo.id,
                  :combustivel_ids => [combustivel.id]
  motorista = Factory.create :motorista
  requisicao = Factory.create :requisicao,
                              :categoria_de_veiculo_id => categoria_de_veiculo.id,
                              :objetivo_de_reserva_id => objetivo_de_reserva.id
  @viagem = Factory.create :viagem,
                           :motorista_id => motorista.id,
                           :veiculo_id => veiculo.id,
                           :data_partida => requisicao.data_de_reserva,
                           :data_chegada => requisicao.data_de_reserva + 3.days
  requisicao.viagem_id = @viagem.id
  @viagem_id = @viagem.id
end

Quando /^eu escolho "([^\"]*)"$/ do |field|
  choose(field)
end

Dado /^que eu tenha "([^\"]*)" em Motorista$/ do |nome|
  @motorista = Factory.create :motorista, :nome_do_motorista => nome
end

Dado /^que eu tenha um veículo da categoria "([^\"]*)", modelo "([^\"]*)" e placa "([^\"]*)"$/ do |categoria, modelo, placa|
  categoria_de_veiculo = Factory.create :categoria_de_veiculo, :nome => categoria
  combustivel = Factory.create :combustivel
  Factory.create :veiculo,
                  :categoria_de_veiculo_id => categoria_de_veiculo.id,
                  :modelo => modelo,
                  :placa => placa,
                  :combustivel_ids => [combustivel.id]
end


Dado /^que eu tenha uma categoria de veículo "([^\"]*)"$/ do |nome|
  @categoria_de_veiculo = Factory.create :categoria_de_veiculo, :nome => nome
end

Entao /^eu devo ter uma nova viagem$/ do
  motorista = Factory.create :motorista
  viagem = Factory.create :viagem, :motorista_id => motorista.id
  Requisicao.update(@requisicao.id, :viagem_id => viagem.id)
  @requisicao.viagem = viagem
  @viagem_id = viagem.id + 1
end

Quando /^eu preencho "([^\"]*)" com uma data de dois dias seguintes a partir de hoje$/ do |campo|
  fill_in(campo, :with => Date.tomorrow.tomorrow)
end

Quando /^eu preencho "([^\"]*)" com uma data do ano que vem$/ do |campo|
  fill_in(campo, :with => Date.today.years_since(1))
end

Quando /^eu preencho "([^\"]*)" com uma data de um dia seguinte a partir de hoje$/ do |campo|
  fill_in(campo, :with => Date.tomorrow)
end

Quando /^eu preencho "([^\"]*)" com uma data de "([^\"]*)" dias seguintes a partir de hoje$/ do |campo, dias|
  fill_in(campo, :with => (Date.today + dias.to_i.days))
end

Quando /^eu escolho requisição de "([^\"]*)"$/ do |field|

  choose(field)

  if (field == "Ida e Volta")
    @ida_e_volta = true
  else
    @ida_e_volta = false
  end

end

Quando /^eu seleciono "([^\"]*)" em "([^\"]*)"$/ do |value, field|
  select(value, :from => field)
end

Quando /^eu preencho data de reserva de volta com "([^\"]*)"$/ do |value|

  if (@ida_e_volta)
    fill_in('Data de Reserva de Volta', :with => value)
  end

end

Entao /^eu não devo ter requisições em espera$/ do
  requisicoes = Requisicao.all(:conditions => "estado = '"+ Requisicao::ESPERA + "'")
  requisicoes.should be_empty
end

Then /^eu devo ver na linha ([0-9]+) da tabela "([^\"]*)"$/ do |row, table_id, table_cells|
  hash = table_cells.hashes.first
  hash.keys.each_with_index do |header, col|
    within "##{table_id} tr:nth-child(#{row}) td:nth-child(#{col+1})" do |scope|
      pass = false
      hash.keys.each do |each_header|
        begin
          scope.should contain(hash[each_header])
          pass = true
        rescue
        end
      end
      raise "#{header} is not in the cell ##{col+1} of the row ##{row} of the table\n#{scope}" unless pass
    end
  end
end

When /^eu não devo ver "([^\"]*)"$/ do |text|
  response.should_not contain(text)
end

Dado /^que eu tenha um objetivo de reserva "([^\"]*)"$/ do |texto|
  @objetivo_de_reserva = Factory.create :objetivo_de_reserva, :texto => texto
end

