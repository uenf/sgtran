require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))
require "factory_girl"

Given /^que eu tenha ([0-9]+) requisições em espera$/ do |quantidade|
  for pos in (1..quantidade.to_i) do
    veiculo = Factory.create :categoria_de_veiculo
    solicitante = Factory.create :solicitante, :nome => 'fulano ' + pos.to_s
    requisicao = Factory.create :requisicao, :id => pos, :solicitante_id => solicitante.id, :categoria_de_veiculo_id => veiculo.id
  end
end

Then /^eu devo ver a tabela "(.+)" com$/ do |tabela_id, tabela_esperada|
  begin
    tabela_esperada.map_column!("Protocolo") do |data|
      if data == "ID"
        data = @requisicao_filtro.id.to_s
      end
      data
    end  
    tabela_esperada.map_column!("Data") do |data|
      if data == 'Daqui a dois dias'
        data = Date.tomorrow.tomorrow.strftime("%d/%m/%Y")
      end
      data
    end      
  rescue
  end
  tabela_esperada.diff!(tableish("table#" + tabela_id + " tr", "td, th"))
end

#Then /^eu devo ver a tabela (.+) com$/ do |tabela_id, tabela_esperada|
#  begin
#    tabela_esperada.map_column!('Data') do |data|
#      if data == 'Daqui a dois dias'
#        data = Date.tomorrow.tomorrow.strftime("%d/%m/%Y")
#      end
#      data
#    end
#  rescue
#  end
#  tabela_esperada.diff!(tableish("table#" + tabela_id + " tr", "td, th"))
#end

When /^eu aceito a requisição ([0-9]+)$/ do |requisicao_id|
  requisicao = Requisicao.find(requisicao_id)
  requisicao.estado = Requisicao::ACEITA
  requisicao.save!
end


Then /^eu devo ver na linha ([0-9]+) da tabela "([^\"]*)"$/ do |row, table_id, table_cells|
  hash = table_cells.hashes.first
  hash.keys.each_with_index do |header, col|
    within "##{table_id} tbody tr:nth-child(#{row}) td:nth-child(#{col+1})" do |scope|
      pass = false
      hash.keys.each do |each_header|
        begin
          scope.should contain(hash[each_header])
          pass = true
        rescue
        end
      end
      raise "#{header} is not in the cell ##{col+1} of the row ##{row} of the table\n#{scope}" unless pass
    end
  end
end

