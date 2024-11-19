# frozen_string_literal: true

# Activity scoped
module ActivityScoped
  extend ActiveSupport::Concern
  include ProjectScoped

  included do
    before_action :set_activity, only: %i[show update destroy]
    before_action :set_project, only: %i[index create update destroy]

    private

    def set_activity
      @activity = Activity.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render json: { error: 'Activity not found' }, status: :not_found
    end
  end
end
