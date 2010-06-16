Dado /^que eu tenho uma requisição com estado "([^\"]*)"$/ do |estado|
  categoria_de_veiculo = Factory.create :categoria_de_veiculo
  centro = Factory.create :centro
  solicitante = Factory.create :solicitante, :centro_id => centro.id
  motivo = Factory.create :motivo
  objetivo_de_reserva = Factory.create :objetivo_de_reserva
  @requisicao = Factory.build :requisicao, :categoria_de_veiculo_id => categoria_de_veiculo.id,
                                            :solicitante_id => solicitante.id,
                                            :objetivo_de_reserva_id => objetivo_de_reserva.id,
                                            :data_de_reserva => Date.today + 2.days
  case estado.to_s
    when "Em Espera" then
      @requisicao.estado = Requisicao::ESPERA
      @requisicao.save
    when "Rejeitada" then
      @requisicao.estado = Requisicao::REJEITADA
      @requisicao.motivo_id = motivo.id
      @requisicao.save
    when /(C|c)ancelad(o|a) pelo (P|p)rofessor/ then
      @requisicao.estado = Requisicao::CANCELADO_PELO_PROFESSOR
      @requisicao.motivo_professor = "Algum motivo"
      @requisicao.save
    when /(c|C)ancelad(o|a) pelo (S|s)istema/ then
      @requisicao.estado = Requisicao::CANCELADO_PELO_SISTEMA
      @requisicao.motivo_id = motivo.id
      @requisicao.save
    when "Aceita" then
      @requisicao.estado = Requisicao::ACEITA
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
                                     :objetivo_de_reserva_id => objetivo_de_reserva.id,
                                     :data_de_reserva => Date.today + 4.days
  @requisicao_volta.referencia_id = @requisicao_ida.id
  @requisicao_ida.referencia_id = @requisicao_volta.id
  @requisicao_volta.save!
  @requisicao_ida.save!
end

Dado /^que eu estou logado com o login "([^\"]*)" e a senha "([^\"]*)"$/ do |login, senha|
  usuario = Factory.create :usuario, :login => login, :password => senha, :password_confirmation => senha
  Factory.create :usuario_session, :login => usuario.login, :senha => usuario.password
end

Dado /^que eu tenho uma requisição com data de reserva "([^\"]*)" e com solicitante com nome "([^\"]*)" e com matrícula "([^\"]*)"$/ do |data, nome, matricula|
  categoria_de_veiculo = Factory.create :categoria_de_veiculo
  objetivo_de_reserva = Factory.create :objetivo_de_reserva  
  @solicitante = Factory.create :solicitante, :nome => nome, :matricula => matricula
  date = data.split(/Daqui a /)[1].to_i
  @requisicao = Factory.create :requisicao, :categoria_de_veiculo_id => categoria_de_veiculo.id,
                                            :solicitante_id => @solicitante.id,
                                            :objetivo_de_reserva_id => objetivo_de_reserva.id,
                                            :data_de_reserva => Date.today + date.days
end

Dado /^que eu tenho uma requisição com protocolo "([^\"]*)"$/ do |protocolo|
  categoria_de_veiculo = Factory.create :categoria_de_veiculo
  objetivo_de_reserva = Factory.create :objetivo_de_reserva  
  solicitante = Factory.create :solicitante
  @requisicao = Factory.create :requisicao, :id => protocolo,
                                            :categoria_de_veiculo_id => categoria_de_veiculo.id,
                                            :solicitante_id => solicitante.id,
                                            :objetivo_de_reserva_id => objetivo_de_reserva.id
end

Dado /^que eu tenho uma requisição de "([^\"]*)" dias atrás e com estado "([^\"]*)"$/ do |dias, estado|
  centro = Factory.create :centro
  categoria_de_veiculo = Factory.create :categoria_de_veiculo
  objetivo_de_reserva = Factory.create :objetivo_de_reserva  
  solicitante = Factory.create :solicitante, :centro_id => centro.id
  @requisicao = Factory.build :requisicao, 
                              :data_de_reserva => Date.today - dias.to_i.days,
                              :estado => estado,
                              :solicitante_id => solicitante.id,
                              :categoria_de_veiculo_id => categoria_de_veiculo.id,
                              :objetivo_de_reserva_id => objetivo_de_reserva.id
  @requisicao.save_with_validation false
end

Quando /^eu preencho data de "([^\"]*)" com "([^\"]*)"$/ do |campo, data|
  data = data.split(/Daqui a /)[1].to_i
  fill_in(campo, :with => (Date.today + data.days).strftime("%d/%m/%Y"))
end

Quando /^eu escolho "([^\"]*)"$/ do |field|
  choose(field)
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

Quando /^eu não devo ver "([^\"]*)"$/ do |text|
  response.should_not contain(text)
end

Entao /^eu não devo ter requisições em espera$/ do
  requisicoes = Requisicao.all(:conditions => "estado = '"+ Requisicao::ESPERA + "'")
  requisicoes.should be_empty
end

Entao /^eu devo ver na linha ([0-9]+) da tabela "([^\"]*)"$/ do |row, table_id, table_cells|
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



Entao /^a requisição deve estar cancelada pelo professor$/ do
  @requisicao.reload
  @requisicao.estado.should == Requisicao::CANCELADO_PELO_PROFESSOR
end

Entao /^a requisição deve estar cancelada pelo sistema$/ do
  @requisicao.reload
  @requisicao.estado.should == Requisicao::CANCELADO_PELO_SISTEMA
end

Então /^a requisição não deve estar ligada a nenhuma viagem$/ do
  Requisicao.find(@requisicao.id).viagem_id.should be_nil
end

Então /^a requisição não deve estar cancelada$/ do
  @requisicao.estado.should_not == Requisicao::CANCELADO_PELO_PROFESSOR
  @requisicao.estado.should_not == Requisicao::CANCELADO_PELO_SISTEMA
end

Então /^a requisição deve estar ligada a uma viagem$/ do
  @requisicao.reload
  @requisicao.viagem_id.should_not be_nil
end






