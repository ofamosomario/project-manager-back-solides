# frozen_string_literal: true

module Projects
  # Service object for creating Project records
  class CreateService
    attr_reader :errors, :record

    def initialize(parameters = {})
      @parameters = parameters

      @errors = []
      @record = nil
      @success = false
    end

    def self.call(parameters = {})
      service = new(parameters)
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
      record = Project.new
      save_record(record)
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
