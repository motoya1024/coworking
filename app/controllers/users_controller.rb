class UsersController < ApplicationController
  
  def new
    @user = User.new
  end
  
  def index
  end
  
  def show
    @first_day = Date.current
    @time_number = (1..24).to_a
    @week_day = []
    i = 0
    while (i <= 6) do
      @week_day.push(l(@first_day + i, format: :long_mini))
      i += 1
    end
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
