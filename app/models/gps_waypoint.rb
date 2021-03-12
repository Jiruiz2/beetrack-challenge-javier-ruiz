# frozen_string_literal: true

class GpsWaypoint < ApplicationRecord
  validates :latitude, :longitude, :sent_at, :vehicle_identifier, presence: true

  validates :vehicle_identifier, uniqueness: { scope: :sent_at,
                                               message: 'Gps Waypoint request is duplicated' }
  validate :past_date

  def self.last_waypoints
    vehicle_identifier_list = GpsWaypoint.distinct.pluck(:vehicle_identifier)
    vehicle_identifier_list.map do |vehicle_identifier|
      GpsWaypoint.where(vehicle_identifier: vehicle_identifier).order(sent_at: :desc).first
    end
  end

  private

  def past_date
    if sent_at.present? && sent_at > DateTime.now
      errors.add(:start, 'sent_at date cannot be in the future')
    end
  end
end
