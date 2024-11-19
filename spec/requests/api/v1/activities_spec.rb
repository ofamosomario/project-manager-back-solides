# frozen_string_literal: true

require 'spec_helper'
require 'swagger_helper'

RSpec.describe 'api/v1/projects/{project_id}/activities', type: :request do
  path '/api/v1/projects/{project_id}/activities' do
    parameter name: :project_id, in: :path, type: :integer, description: 'Project ID'
    get 'List all activities under a project' do
      tags 'Activities'
      produces 'application/json'
      response '200', 'Activities retrieved' do
        let(:project) { create(:project) }
        let(:project_id) { project.id }

        schema type: :object,
               properties: {
                  data: {
                    type: :array,
                    items: {
                      type: :object,
                      properties: {
                        id: { type: :string },
                        type: { type: :string, example: 'activity' },
                        attributes: {
                          type: :object,
                          properties: {
                            name: { type: :string },
                            start_date: { type: :string, format: :date },
                            end_date: { type: :string, format: :date },
                            finished: { type: :boolean }
                          },
                          required: %w[name start_date end_date finished]
                        }
                      },
                      required: %w[id type attributes]
                    }
                  }
              }

        before do
          create_list(:activity, 3, project: project)
        end

        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data['data'].size).to eq(3)
          data['data'].each do |activity|
            expect(activity['id']).to be_present
            expect(activity['type']).to eq('activity')
            expect(activity['attributes']['name']).to be_a(String)
            expect(Date.parse(activity['attributes']['start_date'])).to be_a(Date)
            expect(Date.parse(activity['attributes']['end_date'])).to be_a(Date)
            expect([true, false]).to include(activity['attributes']['finished'])
          end
        end
      end
    end
  end

  path '/api/v1/projects/{project_id}/activities/{id}' do
    parameter name: :project_id, in: :path, type: :integer, description: 'Project ID'
    parameter name: :id, in: :path, type: :integer, description: 'Activity ID'

    get 'Retrieve a specific activity' do
      tags 'Activities'
      produces 'application/json'

      let(:project) { create(:project) }
      let(:project_id) { project.id }

      shared_examples 'returns 404 with error message' do
        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data['error']).to eq('Activity not found')
        end
      end

      response '200', 'Activity retrieved' do
        let(:activity) { create(:activity, project: project) }
        let(:id) { activity.id }

        schema type: :object,
               properties: {
                  data: {
                    type: :object,
                    properties: {
                      id: { type: :string },
                      type: { type: :string, example: 'activity' },
                      attributes: {
                        type: :object,
                        properties: {
                          name: { type: :string },
                          start_date: { type: :string, format: :date },
                          end_date: { type: :string, format: :date },
                          finished: { type: :boolean }
                        },
                        required: %w[name start_date end_date finished]
                      }
                    },
                    required: %w[id type attributes]
                  }
                }, required: %w[data]

        run_test! do |response|
          data = JSON.parse(response.body)
          activity_data = data['data']

          expect(activity_data['id'].to_i).to eq(activity.id)
          expect(activity_data['type']).to eq('activity')
          attributes = activity_data['attributes']
          expect(attributes['name']).to eq(activity.name)
          expect(Date.parse(attributes['start_date'])).to eq(activity.start_date)
          expect(Date.parse(attributes['end_date'])).to eq(activity.end_date)
          expect(attributes['finished']).to eq(activity.finished)
        end
      end

      response '404', 'Activity not found' do
        let(:id) { -1 }

        it_behaves_like 'returns 404 with error message'
      end
    end

    put 'Update an activity under a project' do
      tags 'Activities'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :activity, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          start_date: { type: :string, format: :date },
          end_date: { type: :string, format: :date },
          finished: { type: :boolean }
        },
        required: %w[name]
      }

      let(:project) { create(:project) }
      let(:project_id) { project.id }
      let(:activity_instance) { create(:activity, project: project) }
      let(:id) { activity_instance.id }

      shared_examples 'returns a 422 error' do
        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data['errors']).to be_present
        end
      end

      response '200', 'Activity updated' do
        let(:activity) { { name: 'New name Activity' } }

        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data['data']['attributes']['name']).to eq('New name Activity')
        end
      end
    end

    delete 'Delete an activity under a project' do
      tags 'Activities'

      let(:project) { create(:project) }
      let(:project_id) { project.id }
      let(:activity_instance) { create(:activity, project: project) }
      let(:id) { activity_instance.id }

      response '200', 'Activity deleted successfully' do
        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data['message']).to eq('Activity deleted successfully.')
        end
      end

      response '404', 'Activity not found' do
        let(:id) { -1 }

        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data['error']).to eq('Activity not found')
        end
      end
    end
  end

  path '/api/v1/projects/{project_id}/activities' do
    parameter name: :project_id, in: :path, type: :integer, description: 'Project ID'

    post 'Create a new activity under a project' do
      tags 'Activities'
      consumes 'application/json'
      parameter name: :activity, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          start_date: { type: :string, format: :date },
          end_date: { type: :string, format: :date },
          finished: { type: :boolean }
        },
        required: %w[name start_date end_date]
      }

      let(:project) { create(:project) }

      response '201', 'Activity created' do
        let(:project_id) { project.id }
        let(:activity) do
          {
            name: 'New Activity',
            start_date: '2024-01-01',
            end_date: '2024-02-01',
            finished: false,
            project_id: project.id
          }
        end

        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data['data']['attributes']['name']).to eq('New Activity')
        end
      end

      response '422', 'Invalid request' do
        let(:project) { create(:project) }
        let(:project_id) { project.id }
        let(:activity) { { name: '' } }

        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data['errors']).to be_present
        end
      end
    end
  end
end
