class ReservationsController < ApplicationController
  
  def index
  end
  
  def new
  end
  
  def create
  end
  
  def edit
    @user = User.find(params[:user_id])
    @reservation = Reservation.find(params[:id])
  end
  
  def update
    @user = User.find(params[:user_id])
    @reservation = Reservation.find(params[:id])
    if  @reservation.update_attributes(reservation_params)
      flash[:success] = "#{@user.name}様の予約情報を更新しました。"
    else
      flash[:danger] = "#{@user.name}様の更新は失敗しました。"
    end
      redirect_to users_url
  end
  
  def destroy
    @user = User.find(params[:user_id])
    @reservation = Reservation.find(params[:id])
  end
  
  private 
  
    def reservation_params
      params.require(:reservation).permit(:meeting_on, :started_at, :finished_at, :telmail_name)
    end
end
