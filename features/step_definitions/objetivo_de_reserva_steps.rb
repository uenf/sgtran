Dado /^que eu tenha um objetivo de reserva "([^\"]*)"$/ do |texto|
  @objetivo_de_reserva = Factory.create :objetivo_de_reserva, :texto => texto
end

Dado /^que o objetivo de reserva esteja "([^\"]*)"$/ do |status|
  @objetivo_de_reserva.update_attribute(:status, status)
end

