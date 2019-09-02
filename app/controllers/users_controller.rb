class UsersController < ApplicationController
  
  def new
    @user = User.new
  end
  
  def index
  end
  
  def show
    @first_day = Date.current
  end
  
  def change_show 
    if params[:prev]
       day = params[:prev]
    elsif params[:next]
       day = params[:next]
    end  
    if day
       @first_day = day.to_date
    end
  end
  
  def create
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
  end
  
  def destroy
  end
  
  private
  
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
