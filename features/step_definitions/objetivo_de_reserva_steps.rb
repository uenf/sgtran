Dado /^que eu tenha um objetivo de reserva "([^\"]*)"( (.+))?$/ do |texto, opcao, obrigatoriedade|
  @objetivo_de_reserva = Factory.create :objetivo_de_reserva, :texto => texto
  if not opcao.blank? and obrigatoriedade == "obrigatório"
    @objetivo_de_reserva.update_attribute(:obrigatorio, true)
  else
    @objetivo_de_reserva.update_attribute(:obrigatorio, false)
  end
end

Dado /^que o objetivo de reserva esteja "([^\"]*)"$/ do |status|
  @objetivo_de_reserva.update_attribute(:status, status)
end

