# frozen_string_literal: true

module Activities
  # Service object for creating Activity records
  class CreateService
    attr_reader :errors, :record

    def initialize(parameters = {}, project = nil)
      @parameters = parameters
      @project = project

      @errors = []
      @record = nil
      @success = false
    end

    def self.call(parameters = {}, project = nil)
      service = new(parameters, project)
      service.call
      service
    end

    def call
      create
      self
    end

    def success?
      @success
    end

    private

    def create
      return unless validate_project

      record = @project.activities.new
      save_record(record)
    end

    def validate_project
      unless @project.present?
        @errors << 'Project not found'
        return false
      end
      true
    end

    def save_record(record)
      record.assign_attributes(@parameters)
      if record.save
        @success = true
        @record = record
      else
        @errors = record.errors.full_messages
      end
    end
  end
end
