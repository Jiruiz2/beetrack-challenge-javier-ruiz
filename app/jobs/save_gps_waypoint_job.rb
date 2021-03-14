# frozen_string_literal: true

class SaveGpsWaypointJob < ApplicationJob
  queue_as :default

  def perform(params)
    gps_waypoint = GpsWaypoint.new(params)

    return ['Tu solicitud ha sido recibida correctamente'.to_json, :created] if gps_waypoint.save

    [gps_waypoint.errors.to_json, :bad_request]
  end

  private

  def json_response(object, status)
    render json: object, status: status
  end
end
