# frozen_string_literal: true

class AddStatusToGpsWaypoint < ActiveRecord::Migration[6.1]
  def change
    add_column :gps_waypoints, :status, :string, :default => 'pending'
    add_column :gps_waypoints, :digest_identifier, :string
  end
end
