class Usuario < ActiveRecord::Base

  acts_as_authentic
  acts_as_authorization_subject

  has_and_belongs_to_many :roles

  validates_presence_of :login,
                        :password,
                        :password_confirmation,
                        :email,
                        :nome

end

