class Cidade < ActiveRecord::Base

  belongs_to :estado

  validates_presence_of :nome, :estado_id

end

