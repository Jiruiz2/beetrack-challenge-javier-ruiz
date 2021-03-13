# frozen_string_literal: true

class GpsWaypoint < ApplicationRecord
  validates :latitude, :longitude, :sent_at, :vehicle_identifier, presence: true

  validates :vehicle_identifier, uniqueness: { scope: :sent_at,
                                               message: 'Gps Waypoint request is duplicated' }
  validate :past_date

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

  private

  def past_date
    if sent_at.present? && sent_at > DateTime.now
      errors.add(:start, 'sent_at date cannot be in the future')
    end
  end
end
