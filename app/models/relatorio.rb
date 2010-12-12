class Relatorio < ActiveRecord::Base

  # begin macumba para fazer um model tableless
  def self.columns() @columns ||= []; end

  def self.column(name, sql_type = nil, default = nil, null = true)
    columns << ActiveRecord::ConnectionAdapters::Column.new(name.to_s, default, sql_type.to_s, null)
  end

  column :ano, :string

  # Essas duas colunas, são para quando puder definir um interfalo de tempo
  # para o relatório. Por enquanto é apenas anual.
  #column :data_inicial, :date
  #column :data_final, :date

  # end macumba para fazer um model tableless

  validates_format_of :ano, :with => /^[0-9]{4}$/

  # Essas validações, são para quando puder definir um interfalo de tempo
  # para o relatório. Por enquanto é apenas anual.

  #validate :validar_data_final_maior_igual_incial,
  #         :validar_data_inicial,
  #         :validar_data_final

  #def validar_data_inicial
  #  begin
  #    self.data_inicial.to_date
  #  rescue
  #    errors.add(:data_inicial, 'inválida')
  #  end
  #end

  #def validar_data_final
  #  begin
  #    self.data_final.to_date
  #  rescue
  #    errors.add(:data_final, 'inválida')
  #  end
  #end

  #def validar_data_final_maior_igual_incial
  #  begin
  #    inicial = self.data_inicial.to_date
  #    final = self.data_final.to_date
  #    unless inicial <= final
  #      errors.add(:data_final, 'deve ser maior ou igual a Data inicial')
  #    end
  #  rescue
  #  end
  #end

end

