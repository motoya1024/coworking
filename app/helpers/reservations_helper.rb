module ReservationsHelper
  
  def reservations_invalid?
    reservations = true
    reservation_params.each do |id,item|
      if item[:started_at].blank? && item[:finished_at].blank?
        next
      elsif item[:started_at].blank? || item[:finished_at].blank?
        reservations = false
        break
      elsif item[:started_at] > item[:finished_at]
        reservations = false
        break
      end
    end
    return reservations
  end
end
