# frozen_string_literal: true

class GetGpsWaypointRequestStatus < PowerTypes::Command.new(:request_id)
  def perform
    gps_waypoint = GpsWaypoint.find_by(request_identifier: @request_id)

    return ['Objeto creado correctamente', :created] if gps_waypoint.status == 'created'

    return ['Request aún no procesada', :ok] if gps_waypoint.status == 'pending'

    ['La fecha ingresada es en el futuro o ya existe la combinación de'\
     ' sent_at y vehicle_identifier', :bad_request]
  end
end
