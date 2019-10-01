class UsersController < ApplicationController
  
  def new
    @user = User.new
  end
  
  def index
    @users = User.paginate(page: params[:page], per_page: 20).search(params[:search])
  end
  
  def show
    @user = User.find(params[:id])
    @first_day = Date.current
    set_reservation_schedule
    @login_user_reservations = Reservation.where(user_id: @user.id).where(meeting_on: Time.zone.today..Float::INFINITY).order(meeting_on: :asc).order(started_at: :asc)
    # @time_number = (0..23).to_a
    # @week_day = []
    # @week_day_origin = []
    # # @times24 = []
    # # @times24test = ["0:00","0:30", "1:00","1:30","2:00","2:30","3:00","3:30","4:00","4:30","5:00",
    # # "5:30", "6:00","6:30","7:00","7:30","8:00","8:30","9:00","9:30","10:00","10:30","11:00","11:30",
    # # "12:00","12:30","13:00","13:30","14:00","14:30","15:00","15:30","16:00","16:30","17:00","17:30","18:00",
    # # "18:30","19:00","19:30","20:00","20:30","21:00","21:30","22:00","22:30","23:00","23:30"]

    # minutes = ["00","30"]
    # i = 0
    # while (i <= 6) do
    #   @week_day.push(l(@first_day + i, format: :long_mini))
    #   @week_day_origin.push(@first_day + i)
    #   i += 1
    # end
    # while(i <= 23) do
    #   minutes.each { |minute|
    #   # @times24.push(i.to_s + ":" + minute)
    #   }
    #   i += 1
    # end
  end
  
  def change_show 
    if params[:prev]
      day = params[:prev]
    elsif params[:next]
      day = params[:next]
    end  
    if day
      @first_day = day.to_date
      @user = User.find(params[:id])
      set_reservation_schedule
      # @week_day = []
      # @week_day_origin = []
      # i = 0
      # while (i <= 6) do
      #   @week_day.push(l(@first_day + i, format: :long_mini))
      #   @week_day_origin.push(@first_day + i)
      #   i += 1
      # end
      # @times24test = ["0:00","0:30", "1:00","1:30","2:00","2:30","3:00","3:30","4:00","4:30","5:00",
      #                 "5:30", "6:00","6:30","7:00","7:30","8:00","8:30","9:00","9:30","10:00","10:30","11:00","11:30",
      #                 "12:00","12:30","13:00","13:30","14:00","14:30","15:00","15:30","16:00","16:30","17:00","17:30",
      #                 "18:00","18:30","19:00","19:30","20:00","20:30","21:00","21:30","22:00","22:30","23:00","23:30"]
    end
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "ユーザーの新規作成に成功しました。"
      redirect_to @user
    else
      render 'new'
    end
  end
  
  def edit_info
    @user = User.find(params[:id])
  end
  
  def update_info
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "#{@user.name}様の基本情報を更新しました。"
    else
      flash[:danger] = "#{@user.name}様の更新は失敗しました。<br>" + @user.errors.full_messages.join("<br>")
    end
    redirect_to users_url
  end
  
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:success] = "#{@user.name}様の情報を削除しました。"
    redirect_to users_url
  end
  
  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
    
    def set_reservation_schedule
      @week_day = (@first_day..@first_day.since(7.days))
      @reservations = Reservation.where("started_at > ?",Time.zone.now)
      @times = 48.times.map.each_with_index {|i| Time.parse("0:00")+30.minutes*i}
      @time_number = 24.times.map.each_with_index {|i| l(Time.parse("0:00")+1.hours*i,format: :shorttime)}
    end
end
