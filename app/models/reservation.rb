class Reservation < ApplicationRecord
  belongs_to :user
  
  validates :meeting_on, presence: true
  validates :telmail_name, length: { maximum: 50 }
  
  # 開始時間のみの更新は無効
  validate :only_started_at_or_only_finished_at_not_update
    # 終了時間のみの更新は無効
  validate :finished_at_is_invalid_without_a_started_at
  # 開始・終了時間どちらも存在する時、開始時間より早い終了時間は無効
  validate :started_at_than_finished_at_fast_if_invalid
  
  def only_started_at_or_only_finished_at_not_update
    errors.add(:started_at, "のみの更新は無効です") if started_at.present? && finished_at.blank?
  end

  def finished_at_is_invalid_without_a_started_at
    errors.add(:finished_at, "のみの更新は無効です") if started_at.blank? && finished_at.present?
  end

  def started_at_than_finished_at_fast_if_invalid
    if started_at.present? && finished_at.present?
      errors.add(:started_at, "より早い退勤時間は無効です") if started_at > finished_at
    end
  end
end
