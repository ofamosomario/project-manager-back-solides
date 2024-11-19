# frozen_string_literal: true

# CreateProjects
class CreateProjects < ActiveRecord::Migration[7.1]
  def change
    create_table :projects do |t|
      t.string :name
      t.date :start_date
      t.date :end_date
      t.boolean :delayed, default: false

      t.timestamps
    end
  end
end
