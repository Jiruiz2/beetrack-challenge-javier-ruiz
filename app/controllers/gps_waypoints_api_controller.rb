# frozen_string_literal: true

class GpsWaypointsApiController < ApiController
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
    @waypoint_params = params.permit(:latitude, :longitude, :vehicle_identifier)
    @waypoint_params['sent_at'] = parsed_date if params['sent_at']
    @waypoint_params
  end

  def parsed_date
    DateTime.parse(params['sent_at'])
  end
end
