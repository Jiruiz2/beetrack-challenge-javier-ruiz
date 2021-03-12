# frozen_string_literal: true

class CreateGpsWaypoints < ActiveRecord::Migration[6.1]
  def change
    create_table :gps_waypoints do |t|
      t.float :latitude
      t.float :longitude
      t.datetime :sent_at
      t.string :vehicle_identifier

      t.timestamps
    end
  end
end
