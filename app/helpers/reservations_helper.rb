module ReservationsHelper

  def get_color(week_day)
    if week_day == Date.current
      "week_today_color"
    elsif week_day.saturday? 
      "text-primary"
    elsif week_day.sunday?
      "text-danger"
    end
  end 
  
  def get_height(started_at,finished_at,week_day)
    if Date.parse(started_at.to_s) == Date.parse(finished_at.to_s)
      time = ((finished_at - started_at)/60/60)
      (time/24.to_f*1776)
    elsif Date.parse(started_at.to_s) == week_day
      time = ((week_day.end_of_day - started_at)/60/60)
      (time/24.to_f*1776)
    elsif Date.parse(finished_at.to_s) == week_day
      time = ((finished_at - week_day.midnight)/60/60)
      (time/24.to_f*1776)
    elsif Date.parse(finished_at.to_s) > week_day && Date.parse(started_at.to_s) < week_day
      1776
    end
  end
  
  def get_position(started_at,finished_at,week_day)
    if Date.parse(started_at.to_s) == Date.parse(finished_at.to_s) || Date.parse(started_at.to_s) == week_day
       time = ((started_at - week_day.midnight)/60/60)
       (time/24.to_f*1776) + 22 
    elsif Date.parse(finished_at.to_s) == week_day || (Date.parse(finished_at.to_s) > week_day && Date.parse(started_at.to_s) < week_day)
      22
    end
  end
end
