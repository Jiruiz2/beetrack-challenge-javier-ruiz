# frozen_string_literal: true

class MapGpsViewController < ActionController::Base
  def show
    @gps_waypoints = GpsWaypoint.last_waypoints.pluck(:vehicle_identifier, :latitude, :longitude)
  end
end
