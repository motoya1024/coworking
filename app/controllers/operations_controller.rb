class OperationsController < ApplicationController
   before_action :admin_user, only: [:edit]
    
  def edit
    @operation = Operation.find(1)
    
  end
  
  def update
    @operation = Operation.find(1)
    if @operation.update_attributes(operation_params)
      flash[:success] = "利用席数#{@operation.seat}席、総席数#{@operation.all_seat}席に変更しました。"
      redirect_to operations_edit_url
    else
      render :edit
    end
  end
  

 private

    def operation_params
      params.require(:operation).permit(:seat,:all_seat)
    end
    
    def admin_user
      redirect_to root_url unless current_user.admin?
    end
end