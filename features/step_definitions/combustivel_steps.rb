Dado /^que eu tenho o combustível "([^\"]*)"$/ do |nome|
  @combustivel = Factory.create :combustivel, :nome => nome
end

