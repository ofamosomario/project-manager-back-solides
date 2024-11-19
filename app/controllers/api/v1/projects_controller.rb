# frozen_string_literal: true

module Api
  module V1
    # api/v1/projects_controller.rb
    class ProjectsController < ApplicationController
      include ProjectScoped

      # GET /api/v1/projects
      def index
        projects = Project.all
        render json: ProjectSerializer.new(projects, include: [:activities]).serializable_hash, status: :ok
      end

      # GET /api/v1/projects/:id
      def show
        render json: ProjectSerializer.new(@project, include: [:activities]).serializable_hash, status: :ok
      end

      # POST /api/v1/projects
      def create
        service = Projects::CreateService.call(project_params)

        if service.success?
          render json: ProjectSerializer.new(service.record).serializable_hash, status: :created
        else
          render json: { errors: service.errors }, status: :unprocessable_entity
        end
      end

      # PUT/PATCH /api/v1/projects/:id
      def update
        service = Projects::UpdateService.call(@project, project_params)

        if service.success?
          render json: ProjectSerializer.new(service.record).serializable_hash, status: :ok
        else
          render json: { errors: service.errors }, status: :unprocessable_entity
        end
      end

      # DELETE /api/v1/projects/:id
      def destroy
        service = Projects::DestroyService.call(@project)

        if service.success?
          render json: { message: 'Project deleted successfully.' }, status: :ok
        else
          render json: { errors: service.errors }, status: :unprocessable_entity
        end
      end

      private

      def project_params
        params.require(:project).permit(:name, :start_date, :end_date, :delayed)
      end
    end
  end
end
