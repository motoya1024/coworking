class UsersController < ApplicationController
  
  def new
    @user = User.new
  end
  
  def index
  end
  
  def show
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
