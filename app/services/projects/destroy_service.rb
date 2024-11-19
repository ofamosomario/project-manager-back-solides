# frozen_string_literal: true

module Projects
  # Service object for deleting Project records
  class DestroyService
    attr_reader :errors, :record

    def initialize(record)
      @record = record
      @errors = []
      @success = false
    end

    def self.call(record)
      service = new(record)
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
      if @record.destroy
        @success = true
        @record = @record
      else
        @errors = @record.errors.full_messages
      end
    end
  end
end
