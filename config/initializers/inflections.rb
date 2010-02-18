# Be sure to restart your server when you modify this file.

# Add new inflection rules using the following format
# (all these examples are active by default):
 ActiveSupport::Inflector.inflections do |inflect|
#   inflect.plural /^(ox)$/i, '\1en'
#   inflect.singular /^(ox)en/i, '\1'
   inflect.irregular 'requisicao', 'requisicoes'
   inflect.irregular 'viagem', 'viagens'
   inflect.irregular 'combustivel', 'combustiveis'
   inflect.irregular 'objetivo_de_reserva', 'objetivos_de_reserva'
#   inflect.uncountable %w( fish sheep )
 end

