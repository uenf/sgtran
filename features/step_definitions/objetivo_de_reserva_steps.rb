Dado /^que eu tenha um objetivo de reserva "([^\"]*)"$/ do |texto|
  @objetivo_de_reserva = Factory.create :objetivo_de_reserva, :texto => texto
end

Dado /^que o objetivo de reserva esteja "([^\"]*)"$/ do |estado|
  @objetivo_de_reserva.estado = estado
  @objetivo_de_reserva.save
end
