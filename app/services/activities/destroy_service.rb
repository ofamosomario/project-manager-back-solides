# frozen_string_literal: true

module Activities
  # Service object for deleting Activity records
  class DestroyService
    attr_reader :errors, :record

    def initialize(activity, project)
      @activity = activity
      @project = project
      @errors = []
      @success = false
    end

    def self.call(activity, project)
      service = new(activity, project)
      service.call
      service
    end

    def call
      destroy
      self
    end

    def success?
      @success
    end

    private

    def destroy
      if validate_association && @activity.destroy
        @success = true
        @record = @activity
      else
        @errors = @activity.errors.full_messages.presence || ['Activity not found in this project']
      end
    end

    def validate_association
      if @activity.project_id != @project.id
        @errors << 'Activity does not belong to the specified project'
        false
      else
        true
      end
    end
  end
end
