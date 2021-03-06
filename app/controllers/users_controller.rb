class UsersController < ApplicationController
  before_action :logged_in_user, only: [:show, :index]
  before_action :correct_user,   only: [:show]
  before_action :admin_user,     only: [:index, :edit_info, :update_info]
  before_action :correct_or_admin_user, only: [:destroy]
  
  def new
    @user = User.new
  end
  
  def index
    @users = User.paginate(page: params[:page], per_page: 20).search(params[:search]).order(id: :asc)
  end
  
  def show
    @user = User.find(params[:id])
    @first_day = Date.current
    set_reservation_schedule
    @login_user_reservations = Reservation.where(user_id: @user.id).where(started_at: Time.zone.now..Float::INFINITY).order(started_at: :asc)
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
    end
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "ユーザーの新規作成に成功しました。"
      redirect_to root_path
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
      flash[:danger] = "基本情報の更新は失敗しました。<br>" + @user.errors.full_messages.join("<br>")
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
      @reservations = Reservation.where("finished_at > ?",Time.zone.now)
      @times = 48.times.map.each_with_index {|i| Time.parse("0:00")+30.minutes*i}
      @time_number = 23.times.map.each_with_index {|i| l(Time.parse("1:00")+1.hours*i,format: :shorttime)}
    end
    
  # beforeアクション

    # ログイン済みユーザーか確認
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "ログインしてください。"
        redirect_to root_path
      end
    end

    # 正しいユーザーかどうか確認
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end
    
    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end
    
    # 正しいユーザー、または、管理者ユーザーかどうか確認
    def correct_or_admin_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user) or current_user.admin?
    end
end
