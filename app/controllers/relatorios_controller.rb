class SistemaController < ApplicationController
  access_control do
    allow :admin
  end

  def index
  end

end

