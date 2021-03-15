# frozen_string_literal: true

class ReceiveGpsWaypoint < PowerTypes::Command.new(:params)
  def perform
    gps_waypoint = GpsWaypoint.new(@params)

    return [gps_waypoint.errors.messages, :bad_request] unless gps_waypoint.save

    request_identifier = add_request_identifier_to_gps_waypoint(gps_waypoint)
    SaveGpsWaypointJob.perform_later(gps_waypoint)
    [request_identifier, :ok]
  end

  private

  def add_request_identifier_to_gps_waypoint(gps_waypoint)
    request_identifier = Digest::MD5.hexdigest("id::#{gps_waypoint.id}")
    gps_waypoint.update!(request_identifier: request_identifier)
    request_identifier
  end
end
