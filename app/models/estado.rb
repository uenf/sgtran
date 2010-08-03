class Estado < ActiveRecord::Base

  belongs_to :cidade

  validates_presence_of :nome, :sigla

end

