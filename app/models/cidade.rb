class Cidade < ActiveRecord::Base

  has_one :estado

  validates_presence_of :nome, :estado_id

end

