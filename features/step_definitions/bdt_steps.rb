Então /^o bdt deve estar ligado à viagem$/ do
  @bdt ||= Bdt.all.first
  @bdt.viagem_id.should == @viagem.id
end

