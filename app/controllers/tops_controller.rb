class TopsController < ApplicationController
  
  def home
    @operation = Operation.find(1)
  end
  
end
