require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))
require "factory_girl"

When /^eu escolho a viagem existente$/ do
  field = "id_da_viagem_" + "#{@viagem.id}"
  choose(field)
end

When /^eu não escolho nenhuma viagem$/ do
end

