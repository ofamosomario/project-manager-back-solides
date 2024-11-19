# frozen_string_literal: true

# CreateActivities
class CreateActivities < ActiveRecord::Migration[7.1]
  def change
    create_table :activities do |t|
      t.string :name
      t.date :start_date
      t.date :end_date
      t.boolean :finished
      t.references :project, null: false, foreign_key: true

      t.timestamps
    end
  end
end
