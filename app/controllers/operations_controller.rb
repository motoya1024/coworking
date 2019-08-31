class OperationsController < ApplicationController
  def edit
    @operation = Operation.find(1)
  end
  
end
