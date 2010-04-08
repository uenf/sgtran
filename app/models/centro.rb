class Centro < ActiveRecord::Base
  belongs_to :solicitante

  validates_presence_of :nome
end

