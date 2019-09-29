module ReservationsHelper

  def get_color(week_day)
    if week_day == Date.current
      return "week_today_color"
    elsif week_day.saturday? 
      return "text-primary"
    elsif week_day.sunday?
      return "text-danger"
    end
  end
  
  def get_height(start_time,end_time)
    time = ((end_time - start_time)/60/60)
    (time/24.to_f*1776)
  end
  
  def get_position(start_time,end_time)
    time = ((end_time - start_time)/60/60)
    (time/24.to_f*1776)+22
  end
end
