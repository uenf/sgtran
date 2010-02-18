Dado /^que eu tenho um combustível "([^\"]*)"$/ do |nome|
  @combustivel = Factory.create :combustivel, :nome => nome
end

