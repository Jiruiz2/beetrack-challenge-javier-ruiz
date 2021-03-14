# frozen_string_literal: true

class SaveGpsWaypointJob < ApplicationJob
  queue_as :default

  def perform(gps_waypoint)
    if sent_at_on_past_date?(gps_waypoint) && !gps_waypoint_duplicated?(gps_waypoint)
      gps_waypoint.update(status: 'created')
    else
      gps_waypoint.update(status: 'bad_request')
    end
  end

  private

  def sent_at_on_past_date?(gps_waypoint)
    gps_waypoint.sent_at < DateTime.now
  end

  def gps_waypoint_duplicated?(gps_waypoint)
    duplicated_waypoints = GpsWaypoint.where(vehicle_identifier: gps_waypoint.vehicle_identifier,
                                             sent_at: gps_waypoint.sent_at, status: 'created')
    duplicated_waypoints.present?
  end
end
