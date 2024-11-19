# frozen_string_literal: true

# Project scoped
module ProjectScoped
  extend ActiveSupport::Concern

  included do
    before_action :set_project, only: %i[show update destroy]

    private

    def set_project
      @project = Project.find(params[:project_id] || params[:id])
    rescue ActiveRecord::RecordNotFound
      render json: { error: 'Project not found' }, status: :not_found
    end
  end
end
