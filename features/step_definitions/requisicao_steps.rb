Dado /^que eu tenho uma requisição com estado "([^\"]*)" e id "([^\"]*)"$/ do |estado, id|
  categoria_de_veiculo = Factory.create :categoria_de_veiculo
  centro = Factory.create :centro
  solicitante = Factory.create :solicitante, :centro_id => centro.id
  motivo = Factory.create :motivo
  objetivo_de_reserva = Factory.create :objetivo_de_reserva
  @requisicao = Factory.build :requisicao, :categoria_de_veiculo_id => categoria_de_veiculo.id,
                                            :solicitante_id => solicitante.id,
                                            :objetivo_de_reserva_id => objetivo_de_reserva.id,
                                            :data_de_reserva => Date.today + 2.days,
                                            :id => id
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

Dado /^que eu tenho um conjunto de requisições$/ do
  @conjunto_de_requisicoes = {}
end

Dado /^que a requisição esteja no meu conjunto de requisições$/ do
  @conjunto_de_requisicoes[@requisicao.id] = @requisicao
end

Dado /^que hoje é (.+) às (\d+):(\d+):(\d+)$/ do |dia, horas, minutos, segundos|
  if dia == "Sexta-Feira"
    time = Time.local(2010, 12, 17, horas.to_i, minutos.to_s, segundos.to_i)
  elsif dia == "Sábado"
    time = Time.local(2010, 12, 18, horas.to_i, minutos.to_s, segundos.to_i)
  elsif dia == "Domingo"
    time = Time.local(2010, 12, 19, horas.to_i, minutos.to_s, segundos.to_i)
  end
  Timecop.freeze(time)
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

Quando /^eu preencho "([^\"]*)" com uma data vazia$/ do |campo|
  fill_in(campo, :with => '')
end

Quando /^eu preencho "([^\"]*)" com uma data de um dia seguinte a partir de hoje$/ do |campo|
  fill_in(campo, :with => Date.tomorrow)
end

Quando /^eu preencho "([^\"]*)" com uma data de "([^\"]*)" dias seguintes a partir de hoje$/ do |campo, dias|
  fill_in(campo, :with => (Date.today + dias.to_i.days))
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

Então /^a requisição não deve estar ligada a uma viagem$/ do
  @requisicao.reload
  @requisicao.viagem_id.should be_nil
end

Então /^eu devo ter (\d+) requisições$/ do |quantidade|
  Requisicao.all.should have(quantidade.to_i).requisicoes
end

Então /^a requisição deve estar ligada à primeira viagem$/ do
  @requisicao.reload
  @requisicao.viagem_id.should == Viagem.all.first.id
end

Então /^a requisição deve estar ligada à última viagem$/ do
  @requisicao.reload
  @requisicao.viagem_id.should == Viagem.all.last.id
end

Então /^a requisição com id "([^"]*)" não deve estar ligada a uma viagem$/ do |requisicao_id|
  Requisicao.find(requisicao_id).viagem_id.should be_nil
end

Então /^a requisição com id "([^"]*)" deve estar ligada a uma viagem$/ do |requisicao_id|
  Requisicao.find(requisicao_id).viagem_id.should_not be_nil
end

Então /^o local de origem da requisição com id "([^"]*)" deve ser "([^"]*)" do "([^"]*)"$/ do |requisicao_id, city, sigla|
  estado = Estado.find_by_sigla(sigla)
  cidade = Cidade.find_by_estado_id_and_nome(estado.id, city)
  @requisicao = @conjunto_de_requisicoes[requisicao_id.to_i]
  @requisicao.reload
  @requisicao.local_origem_id.should == cidade.id
end

Então /^o local de destino da requisição com id "([^"]*)" deve ser "([^"]*)" do "([^"]*)"$/ do |requisicao_id, city, sigla|
  estado = Estado.find_by_sigla(sigla)
  cidade = Cidade.find_by_estado_id_and_nome(estado.id, city)
  @requisicao = @conjunto_de_requisicoes[requisicao_id.to_i]
  @requisicao.reload
  @requisicao.local_destino_id.should == cidade.id
end

Então /^que o Timecop volta ao normal$/ do
  Timecop.return
end

