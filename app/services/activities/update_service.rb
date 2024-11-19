# frozen_string_literal: true

module Activities
  # Service object for updating Activity records
  class UpdateService
    attr_reader :errors, :record

    def initialize(activity, project, parameters = {})
      @activity = activity
      @project = project
      @parameters = parameters
      @errors = []
      @success = false
    end

    def self.call(activity, project, parameters = {})
      service = new(activity, project, parameters)
      service.call
      service
    end

    def call
      return unless validate_association

      update_record(@activity)
    end

    def success?
      @success
    end

    private

    def validate_association
      if @activity.project_id != @project.id
        @errors << 'Activity does not belong to the specified project'
        false
      else
        true
      end
    end

    def update_record(activity)
      if activity.update(@parameters)
        @success = true
        @record = activity
      else
        @errors = activity.errors.full_messages
      end
    end
  end
end