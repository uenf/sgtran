Dado /^que eu tenho um motivo com descrição "([^\"]*)"$/ do |motivo|
  Factory.create :motivo, :descricao => motivo
end
