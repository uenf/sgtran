class Relatorio < ActiveRecord::Base

  # begin macumba para fazer um model tableless
  def self.columns() @columns ||= []; end

  def self.column(name, sql_type = nil, default = nil, null = true)
    columns << ActiveRecord::ConnectionAdapters::Column.new(name.to_s, default, sql_type.to_s, null)
  end

  column :data_inicio, :date
  column :data_fim, :date
  # end macumba para fazer um model tableless

  attr_accessor :data_inicio, :data_fim

  validate :validar_data_inicio, :validar_data_fim

  def validar_data_inicio
    begin
      self.data_inicio.to_date
    rescue
      errors.add(:data_inicio, 'inválida')
    end
  end

  def validar_data_fim
    begin
      self.data_fim.to_date
    rescue
      errors.add(:data_fim, 'inválida')
    end
  end

  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end


end

