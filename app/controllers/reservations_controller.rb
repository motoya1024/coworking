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
    @usage_time = params[:usage_time].to_i
    @reservation.finished_at = @reservation.started_at+@usage_time.minutes
    if @user.admin?
      if @reservation.save
        flash[:success] = "予約が完了しました。"
      else
        flash[:danger] = "予約ができませんでした。"
      end
    else
      if @reservation.save(context: :telmail)
        flash[:success] = "予約が完了しました。"
      else
        flash[:danger] = "予約ができませんでした。"
      end
    end
    redirect_to @user
  end
  
  def edit
    @user = User.find(params[:user_id])
    @reservation = Reservation.find(params[:id])
  end
  
  def update
    @user = User.find(params[:user_id])
    @reservation = Reservation.find(params[:id])
    @usage_time = params[:usage_time].to_i
    @update_reservation = Reservation.new(reservation_params)
    @reservation.finished_at = @update_reservation.started_at+@usage_time.minutes
    if @reservation.update_attributes(reservation_params)
      flash[:success] = "#{@reservation.telmail_name}様の予約情報を更新しました。"
    else
      flash[:danger] = "予約情報の更新は失敗しました。"
    end
      redirect_to @user
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
