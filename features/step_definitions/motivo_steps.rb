Dado /^que eu tenho um motivo com descrição "([^\"]*)"$/ do |motivo|
  @motivo = Factory.create :motivo, :descricao => motivo
end

Dado /^que o motivo esteja "([^\"]*)"$/ do |estado|
  @motivo.estado = estado
end
