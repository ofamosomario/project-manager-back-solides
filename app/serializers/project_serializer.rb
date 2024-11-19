# frozen_string_literal: true

# app/serializers/project_serializer.rb
class ProjectSerializer
  include JSONAPI::Serializer

  set_type :project
  attributes :name, :start_date, :end_date, :delayed

  has_many :activities

  attribute :progress_percentage, &:progress_percentage
end
