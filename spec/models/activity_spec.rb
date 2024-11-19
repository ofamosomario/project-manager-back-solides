# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Activity, type: :model do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:start_date) }
  it { should validate_presence_of(:end_date) }
  it { should allow_value(true, false).for(:finished) }

  it { should belong_to(:project) }

  context 'validations' do
    it 'is invalid if end_date is earlier than start_date' do
      activity = Activity.new(
        name: 'Test',
        start_date: Date.today,
        end_date: Date.yesterday,
        project: create(:project)
      )
      expect(activity).not_to be_valid
      expect(activity.errors[:end_date]).to include('deve ser posterior à data de início')
    end
  end
end
