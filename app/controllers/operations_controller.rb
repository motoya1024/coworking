class OperationsController < ApplicationController
    
  def edit
    @operation = Operation.find(1)
    
  end
  
  def update
    @operation = Operation.find(1)
    if @operation.update_attributes(operation_params)
      flash[:success] = "利用席数を#{@operation.seat}席に変更しました。"
      redirect_to operations_edit_path
    else
      render operations_edit_path
    end
  end
  

 private

    def operation_params
      params.require(:operation).permit(:seat)
    end
end