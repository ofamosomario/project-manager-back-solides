# frozen_string_literal: true

# Activity
class Activity < ApplicationRecord
  belongs_to :project

  with_options presence: true do
    validates :name, :start_date, :end_date
  end

  after_save :check_project_delay

  validates :finished, inclusion: { in: [true, false] }
  validate :start_date_before_end_date

  private

  def check_project_delay
    project.check_and_set_delayed!
  end

  def start_date_before_end_date
    return unless start_date.present? && end_date.present? && start_date > end_date

    errors.add(:end_date, 'deve ser posterior à data de início')
  end
end
