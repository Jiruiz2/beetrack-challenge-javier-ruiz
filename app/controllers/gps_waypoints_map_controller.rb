# frozen_string_literal: true

class GpsWaypointsMapController < ApplicationController
  def show
    @gps_waypoints = GpsWaypoint.last_waypoints.pluck(:vehicle_identifier, :latitude, :longitude)
  end

  def documentation; end
end
