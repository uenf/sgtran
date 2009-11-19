require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))
require "factory_girl"

Dado /^que eu tenho o combustivel "([^\"]*)"$/ do |nome|
  Factory.create :combustivel, :nome => nome
end

Dado /^que eu tenho a categoria de veiculo "([^\"]*)"$/ do |nome|
  Factory.create :categoria_de_veiculo, :nome => nome
end

