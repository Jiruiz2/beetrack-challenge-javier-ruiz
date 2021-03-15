# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'GpsWaypointsApi', type: :request do
  before do
    Timecop.freeze(DateTime.new(2021, 3, 12, 12, 0, 0))
  end

  after do
    Timecop.return
  end

  describe 'POST /api/v1/gps' do
    let(:params) do
      {
        'longitude' => -0.5, 'latitude' => 1.5,
        'sent_at' => '2021/3/11 12:00:00',  'vehicle_identifier' => 'test'
      }
    end
    let(:request_id) { 'test'.to_json }

    before do
      allow_any_instance_of(ReceiveGpsWaypoint).to receive(:perform).and_return('test')
    end

    it 'render json response and has ok status' do
      post '/api/v1/gps', params: params

      expect(response.body).to eq(request_id)
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET /api/v1/gps_status' do
    let(:params) { 'request_id=test' }

    before do
      allow_any_instance_of(GetGpsWaypointRequestStatus).to receive(:perform).and_return(
        ['ok', :created]
      )
    end

    it 'render json response and has ok status' do
      get "/api/v1/gps_status?#{params}"

      expect(response.body).to eq('ok'.to_json)
      expect(response).to have_http_status(:created)
    end
  end
end
