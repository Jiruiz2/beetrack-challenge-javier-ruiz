# frozen_string_literal: true

class AddUniqueSentAtVehicleIndexToGpsWaypoint < ActiveRecord::Migration[6.1]
  def change
    add_index :gps_waypoints, [:vehicle_identifier, :sent_at], unique: true
  end
end
