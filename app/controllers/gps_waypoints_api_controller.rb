# frozen_string_literal: true

class GpsWaypointsApiController < ApiController
  def receive_gps_waypoint
    response, status = ReceiveGpsWaypoint.for(params: gps_waypoint_params)

    json_response(response, status)
  end

  def gps_waypoint_status
    response, status = GetGpsWaypointRequestStatus.for(
      request_id: request_status_params[:request_id]
    )

    json_response(response, status)
  end

  private

  def gps_waypoint_params
    @waypoint_params = params.permit(:latitude, :longitude, :vehicle_identifier)
    @waypoint_params['sent_at'] = parsed_date if params['sent_at']
    @waypoint_params
  end

  def request_status_params
    params.permit(:request_id)
  end

  def parsed_date
    DateTime.parse(params['sent_at'])
  end
end
