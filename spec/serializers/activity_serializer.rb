# frozen_string_literal: true

# spec/serializers/activity_serializer_spec.rb
require 'rails_helper'

RSpec.describe ActivitySerializer, type: :serializer do
  let(:project) { create(:project) }
  let(:activity) { create(:activity, project: project) }
  let(:serializer) { described_class.new(activity) }

  it 'returns the correct type' do
    serialized_data = serializer.serializable_hash[:data]
    expect(serialized_data[:type]).to eq(:activity)
  end

  it 'returns the correct attributes' do
    serialized_data = serializer.serializable_hash[:data][:attributes]

    expect(serialized_data[:name]).to eq(activity.name)
    expect(serialized_data[:start_date]).to eq(activity.start_date)
    expect(serialized_data[:end_date]).to eq(activity.end_date)
    expect(serialized_data[:finished]).to eq(activity.finished)
  end
end
