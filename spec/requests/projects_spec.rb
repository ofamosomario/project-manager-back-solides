# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Projects API', type: :request do
  describe 'GET /api/v1/projects/:id' do
    let(:project) { create(:project) }

    context 'progress percentage' do
      before do
        create_list(:activity, 3, project: project, finished: true)
        create_list(:activity, 2, project: project, finished: false)
      end

      it 'returns the correct progress percentage' do
        get "/api/v1/projects/#{project.id}", headers: { 'Accept': 'application/vnd.api+json' }

        expect(response).to have_http_status(:ok)
        data = JSON.parse(response.body)['data']
        attributes = data['attributes']
        expect(attributes['progress_percentage']).to eq(60.0)
      end
    end

    context 'delayed status' do
      it 'returns true for delayed' do
        create(:activity, project: project, finished: false, end_date: Date.yesterday)

        get "/api/v1/projects/#{project.id}", headers: { 'Accept': 'application/vnd.api+json' }

        expect(response).to have_http_status(:ok)
        data = JSON.parse(response.body)['data']
        attributes = data['attributes']
        expect(attributes['delayed']).to eq(true)
      end

      it 'returns false for non-delayed' do
        create(:activity, project: project, finished: true, end_date: Date.tomorrow)

        get "/api/v1/projects/#{project.id}", headers: { 'Accept': 'application/vnd.api+json' }

        expect(response).to have_http_status(:ok)
        data = JSON.parse(response.body)['data']
        attributes = data['attributes']
        expect(attributes['delayed']).to eq(false)
      end
    end
  end
end