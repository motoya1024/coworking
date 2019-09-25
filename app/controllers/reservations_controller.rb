class ReservationsController < ApplicationController
  
  def index
  end
  
  def new
    @user = User.find(params[:user_id])
    @reservation = Reservation.new
    @times24 = []
    minutes = ["00","30"]
    i = 0
    while(i <= 23) do
      minutes.each { |minute|
      @times24.push(i.to_s + ":" + minute)
      }
      i += 1
    end
    @selected_started_at = params[:started_at]
    @week_day = params[:week_day]
  end
  
  def create
    @user = User.find(params[:user_id])
    @reservation = Reservation.new(customer_reservation_params)
    @reservation.save
    flash[:success] = "予約が完了しました。"
    redirect_to @user
  end
  
  def edit
    @user = User.find(params[:user_id])
    @reservation = Reservation.find(params[:id])
  end
  
  def update
    @user = User.find(params[:user_id])
    @reservation = Reservation.find(params[:id])
    if @reservation.update_attributes(reservation_params)
    # if reservations_invalid?
    #   reservation_params.each do |id,item|
    #     reservation = Reservation.find(id)
    #     reservation.update_attributes!(item)
    #   end
      flash[:success] = "#{@user.name}様の予約情報を更新しました。"
    else
      flash[:danger] = "#{@user.name}様の更新は失敗しました。"
    end
      redirect_to users_url
  end
  
  def show
    @user = User.find(params[:user_id])
    @reservation = Reservation.find(params[:id])
    @times24 = []
    i = 0
    minutes = ["00","30"]
    while(i <= 23) do
      minutes.each { |minute|
      @times24.push(i.to_s + ":" + minute)
      }
      i += 1
    end
  end
  
  def destroy
    @user = User.find(params[:user_id])
    @reservation = Reservation.find(params[:id])
    Reservation.find(params[:id]).destroy
    flash[:success] = "削除しました。"
    redirect_to user_url(@user)
  end
  
  private 
  
    def reservation_params
      params.require(:reservation).permit(:meeting_on, :started_at, :finished_at, :telmail_name)
    end
    
    def customer_reservation_params
      params.require(:reservation).permit(:user_id, :meeting_on, :started_at, :finished_at, :telmail_name)
    end
end
