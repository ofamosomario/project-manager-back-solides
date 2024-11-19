# frozen_string_literal: true

# Project
class Project < ApplicationRecord
  has_many :activities, dependent: :destroy

  with_options presence: true do
    validates :name, :start_date, :end_date
  end

  validate :start_date_before_end_date

  def progress_percentage
    total_activities = activities.count
    return 0 if total_activities.zero?

    completed_activities = activities.where(finished: true).count
    ((completed_activities.to_f / total_activities) * 100).round(2)
  end

  def check_and_set_delayed!
    return unless activities.where(finished: false).where('end_date < ?', Date.today).exists?

    update!(delayed: true)
  end

  private

  def start_date_before_end_date
    return unless start_date.present? && end_date.present? && start_date > end_date

    errors.add(:end_date, 'deve ser posterior à data de início')
  end
end
