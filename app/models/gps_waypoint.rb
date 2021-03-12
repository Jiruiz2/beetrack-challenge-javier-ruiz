# frozen_string_literal: true

class GpsWaypoint < ApplicationRecord
  validates :latitude, :longitude, :sent_at, :vehicle_identifier, presence: true

  validates :vehicle_identifier, uniqueness: { scope: :sent_at,
                                               message: 'Gps Waypoint request is duplicated' }
end
