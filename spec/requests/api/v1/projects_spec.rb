# frozen_string_literal: true

require 'spec_helper'
require 'swagger_helper'

RSpec.describe 'api/v1/projects', type: :request do
  path '/api/v1/projects' do
    get 'Retrieve all projects' do
      tags 'Projects'
      produces 'application/json'

      response '200', 'Projects retrieved' do
        schema type: :object,
               properties: {
                 data: {
                   type: :array,
                   items: {
                     type: :object,
                     properties: {
                       id: { type: :string },
                       type: { type: :string, example: 'project' },
                       attributes: {
                         type: :object,
                         properties: {
                           name: { type: :string },
                           start_date: { type: :string, format: :date },
                           end_date: { type: :string, format: :date }
                         },
                         required: %w[name start_date end_date]
                       }
                     },
                     required: %w[id type attributes]
                   }
                 }
               }

        before do
          create_list(:project, 3)
        end

        run_test! do |response|
          data = JSON.parse(response.body)['data']
          expect(data.size).to eq(3)
          data.each do |project|
            expect(project['id']).to be_a(String)
            expect(project['attributes']['name']).to be_a(String)
            expect(Date.parse(project['attributes']['start_date'])).to be_a(Date)
            expect(Date.parse(project['attributes']['end_date'])).to be_a(Date)
          end
        end
      end
    end

    post 'Create a project' do
      tags 'Projects'
      consumes 'application/json'
      parameter name: :project, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          start_date: { type: :string, format: :date },
          end_date: { type: :string, format: :date },
          delayed: { type: :boolean }
        },
        required: %w[name start_date end_date]
      }

      response '201', 'Project created' do
        let(:project) { { name: 'New Project', start_date: '2024-01-01', end_date: '2024-12-31' } }
        run_test!
      end

      response '422', 'Invalid request' do
        let(:project) { { name: '' } }
        run_test!
      end
    end
  end

  path '/api/v1/projects/{id}' do
    parameter name: :id, in: :path, type: :integer, description: 'Project ID'

    get 'Retrieve a project' do
      tags 'Projects'
      produces 'application/json'

      response '200', 'Project retrieved' do
        let(:project) { create(:project) }
        let(:id) { project.id }

        schema type: :object,
        properties: {
          data: {
            type: :object,
            properties: {
              id: { type: :string },
              type: { type: :string, example: 'project' },
              attributes: {
                type: :object,
                properties: {
                  name: { type: :string },
                  start_date: { type: :string, format: :date },
                  end_date: { type: :string, format: :date },
                  delayed: { type: :boolean }
                },
                required: %w[name start_date end_date]
              }
            },
            required: %w[id type attributes]
          }
        }, required: %w[data]

        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data['data']['id']).to eq(id.to_s)
          expect(data['data']['attributes']['name']).to eq(project.name)
        end
      end

      response '404', 'Project not found' do
        let(:id) { -1 }
        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data['error']).to eq('Project not found')
        end
      end
    end

    put 'Update a project' do
      tags 'Projects'
      consumes 'application/json'
      parameter name: :project, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          start_date: { type: :string, format: :date },
          end_date: { type: :string, format: :date },
          delayed: { type: :boolean }
        }
      }

      response '200', 'Project updated' do
        let(:id) { create(:project).id }
        let(:project) { { name: 'Updated Project' } }
        run_test!
      end
    end

    delete 'Delete a project' do
      tags 'Projects'
      produces 'application/json'

      response '200', 'Project deleted successfully' do
        let(:project) { create(:project) }
        let(:id) { project.id }

        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data['message']).to eq('Project deleted successfully.')
        end
      end

      response '404', 'Unable to delete the project' do
        let(:id) { -1 }

        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data['error']).to be_present
        end
      end
    end
  end
end
