# frozen_string_literal: true

module Api
  module V1
    # api/v1/projects_controller.rb
    class ActivitiesController < ApplicationController
      include ActivityScoped

      # GET /api/v1/projects/:project_id/activities
      def index
        activities = @project.activities
        render json: ActivitySerializer.new(activities).serializable_hash, status: :ok
      end

      # GET /api/v1/projects/:project_id/activities/:id
      def show
        render json: ActivitySerializer.new(@activity).serializable_hash, status: :ok
      end

      # POST /api/v1/projects/:project_id/activities
      def create
        service = Activities::CreateService.call(activity_params, @project)

        if service.success?
          render json: ActivitySerializer.new(service.record).serializable_hash, status: :created
        else
          render json: { errors: service.errors }, status: :unprocessable_entity
        end
      end

      # PUT/PATCH /api/v1/projects/:project_id/activities/:id
      def update
        service = Activities::UpdateService.call(@activity, @project, activity_params)

        if service.success?
          render json: ActivitySerializer.new(service.record).serializable_hash, status: :ok
        else
          render json: { errors: service.errors }, status: :unprocessable_entity
        end
      end

      # DELETE /api/v1/projects/:project_id/activities/:id
      def destroy
        service = Activities::DestroyService.call(@activity, @project)
        if service.success?
          render json: { message: 'Activity deleted successfully.' }, status: :ok
        else
          render json: { errors: service.errors }, status: :unprocessable_entity
        end
      end

      private

      def activity_params
        params.require(:activity).permit(:name, :start_date, :end_date, :finished, :project_id)
      end
    end
  end
end
