# frozen_string_literal: true

class GpsWaypointsController < ApplicationController
  def receive_gps_waypoint
    gps_waypoint = GpsWaypoint.new(gps_waypoint_params)

    if gps_waypoint.save
      json_response('Tu solicitud ha sido recibida correctamente'.to_json, :created)
    else
      json_response(gps_waypoint.errors, :bad_request)
    end
  end

  private

  def gps_waypoint_params
    params.permit(:latitude, :longitude, :sent_at, :vehicle_identifier)
  end
end
