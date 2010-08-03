Então /^o bdt deve estar ligado à viagem$/ do
  @bdt ||= Bdt.all.first
  @bdt.viagem_id.should == @viagem.id
end

Dado /^que eu tenho um BDT$/ do
  @bdt = Factory.create :bdt
end

Dado /^que o BDT esteja ligado à viagem$/ do
  @bdt.viagem_id = @viagem.id
  @bdt.save
end

