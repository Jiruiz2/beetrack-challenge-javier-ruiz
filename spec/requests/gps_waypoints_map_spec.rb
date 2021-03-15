# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'MapGpsView', type: :request do
  def gps_waypoint_information(gps_waypoint)
    "[\"#{gps_waypoint.vehicle_identifier}\", #{gps_waypoint.latitude}, #{gps_waypoint.longitude}]"
  end

  before do
    Timecop.freeze(DateTime.new(2021, 3, 12, 12, 0, 0))
  end

  after do
    Timecop.return
  end

  let(:date) { DateTime.new(2021, 3, 10, 12, 0, 0) }
  let(:future_date) { DateTime.new(2021, 3, 11, 12, 0, 0) }

  describe 'GET /show' do
    let!(:gps_waypoint1) do
      create(:gps_waypoint, sent_at: date, vehicle_identifier: 'test', status: 'created')
    end
    let!(:gps_waypoint2) do
      create(:gps_waypoint, sent_at: future_date, vehicle_identifier: 'test', status: 'pending')
    end
    let!(:gps_waypoint3) do
      create(:gps_waypoint, sent_at: future_date, vehicle_identifier: 'test', status: 'bad_request')
    end
    let!(:gps_waypoint4) { create(:gps_waypoint, sent_at: date, status: 'created') }

    let(:last_waypoints) do "[#{gps_waypoint_information(gps_waypoint1)}, "\
    "#{gps_waypoint_information(gps_waypoint4)}]"
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
