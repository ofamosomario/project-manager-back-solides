# frozen_string_literal: true

# app/serializers/activity_serializer.rb
class ActivitySerializer
  include JSONAPI::Serializer

  set_type :activity
  attributes :name, :start_date, :end_date, :finished

  belongs_to :project
end
