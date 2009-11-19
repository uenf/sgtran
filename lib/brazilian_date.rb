module BrazilianDate

  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def use_in_brazilian_format(*fields)
      fields.each do |field|
        self.class_eval <<-EVAL
          validate :validate_dates

          def #{field}_br=(value)
            if value.blank?
              self.#{field} = nil
            else
              day, month, year = value.split('/')
              begin
                self.#{field} = Time.parse("\#{month}/\#{day}/\#{year}")
              rescue ArgumentError
                @date_errors ||= {}
                @date_errors[:#{field}] = "inválida"
              end
            end
          end
          def #{field}_br
            #{field}
          end

          def validate_dates
            if @date_errors
              @date_errors.each_pair do |field, message|
                errors.add(field, message)
              end
            end
          end
        EVAL
      end
    end
  end

end

ActiveRecord::Base.send(:include, BrazilianDate)

