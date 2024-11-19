# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Project, type: :model do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:start_date) }
  it { should validate_presence_of(:end_date) }

  it { should have_many(:activities).dependent(:destroy) }

  context 'validations' do
    it 'is invalid if end_date is earlier than start_date' do
      project = Project.new(name: 'Test Project', start_date: Date.today, end_date: Date.yesterday)
      expect(project).not_to be_valid
      expect(project.errors[:end_date]).to include('deve ser posterior à data de início')
    end
  end
end
