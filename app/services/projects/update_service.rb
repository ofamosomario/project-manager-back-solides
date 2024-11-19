# frozen_string_literal: true

module Projects
  # Service object for updating Project records
  class UpdateService
    attr_reader :errors, :record

    def initialize(record, parameters = {})
      @record = record
      @parameters = parameters
      @errors = []
      @success = false
    end

    def self.call(record, parameters = {})
      service = new(record, parameters)
      service.call
      service
    end

    def call
      update
      self
    end

    def success?
      @success
    end

    private

    def update
      update_record(@record)
    end

    def update_record(record)
      if record.update(@parameters)
        @success = true
        @record = record
      else
        @errors = record.errors.full_messages
      end
    end
  end
end
