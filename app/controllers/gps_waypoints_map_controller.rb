# frozen_string_literal: true

class GpsWaypointsMapController < ApplicationController
  def show
    @gps_waypoints = GpsWaypoint.last_waypoints.map do | gps_waypoint |
      { 'latitude' => gps_waypoint.latitude, 'longitude' => gps_waypoint.longitude, 
        'vehicle_identifier' => gps_waypoint.vehicle_identifier }
    end
  end

  def documentation; end
end
