# frozen_string_literal: true

class GpsWaypoint < ApplicationRecord
  validates :latitude, :longitude, :sent_at, :vehicle_identifier, presence: true
  enum_for :status, in: %w{pending created bad_request}

  scope :last_waypoints, -> do
    from(
      <<~SQL.squish
        (
          SELECT vehicle_identifier, latitude, longitude, max(sent_at) AS sent_at
          FROM gps_waypoints
          GROUP BY vehicle_identifier
        ) gps_waypoints
      SQL
    )
  end
end
