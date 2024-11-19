# frozen_string_literal: true

# spec/serializers/project_serializer_spec.rb
require 'rails_helper'

RSpec.describe ProjectSerializer, type: :serializer do
  let(:project) { create(:project) }
  let(:activities) { create_list(:activity, 3, project: project) }
  let(:serializer) { described_class.new(project) }

  it 'returns the correct type' do
    serialized_data = serializer.serializable_hash[:data]
    expect(serialized_data[:type]).to eq(:project)
  end

  it 'returns the correct attributes' do
    serialized_data = serializer.serializable_hash[:data][:attributes]
    expect(serialized_data[:name]).to eq(project.name)
    expect(serialized_data[:start_date]).to eq(project.start_date)
    expect(serialized_data[:end_date]).to eq(project.end_date)
    expect(serialized_data[:delayed]).to eq(project.delayed)
  end

  it 'includes progress_percentage and delayed' do
    serialized_data = serializer.serializable_hash[:data][:attributes]
    expect(serialized_data).to include(:progress_percentage)
  end
end
