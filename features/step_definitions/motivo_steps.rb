Dado /^que eu tenho um motivo com descrição "([^\"]*)"$/ do |motivo|
  @motivo = Factory.create :motivo, :descricao => motivo
end

