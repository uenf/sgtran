class Relatorio < ActiveRecord::Base

  # begin macumba para fazer um model tableless
  def self.columns() @columns ||= []; end

  def self.column(name, sql_type = nil, default = nil, null = true)
    columns << ActiveRecord::ConnectionAdapters::Column.new(name.to_s, default, sql_type.to_s, null)
  end

  column :data_inicial, :date
  column :data_final, :date
  # end macumba para fazer um model tableless

  validate :validar_data_inicial, :validar_data_final

  def validar_data_inicial
    begin
      self.data_inicial.to_date
    rescue
      errors.add(:data_inicial, 'inválida')
    end
  end

  def validar_data_final
    begin
      self.data_final.to_date
    rescue
      errors.add(:data_final, 'inválida')
    end
  end

end

