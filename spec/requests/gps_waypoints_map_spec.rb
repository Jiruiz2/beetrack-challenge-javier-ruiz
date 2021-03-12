# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'MapGpsView', type: :request do
  def gps_waypoint_information(gps_waypoint)
    "[\"#{gps_waypoint.vehicle_identifier}\", #{gps_waypoint.latitude}, #{gps_waypoint.longitude}]"
  end

  describe 'GET /show' do
    let!(:gps_waypoint1) { create(:gps_waypoint) }
    let!(:gps_waypoint2) { create(:gps_waypoint) }
    let!(:gps_waypoint3) { create(:gps_waypoint) }
    let(:last_waypoints) do "[#{gps_waypoint_information(gps_waypoint1)}, "\
    "#{gps_waypoint_information(gps_waypoint2)}, #{gps_waypoint_information(gps_waypoint3)}]"
    end

    it 'render show view' do
      get '/show'

      expect(response).to be_successful
      expect(response).to render_template('show')
      expect(response.body).to match(/#{last_waypoints}/)
    end
  end

  describe 'GET /' do
    it 'render documentation view' do
      get '/'

      expect(response).to render_template('documentation')
      expect(response).to be_successful
    end
  end
end
