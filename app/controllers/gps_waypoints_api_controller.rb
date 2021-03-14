# frozen_string_literal: true

class GpsWaypointsApiController < ApiController
  def receive_gps_waypoint
    response, status = SaveGpsWaypointJob.perform_now(gps_waypoint_params)
    json_response(response, status)
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
