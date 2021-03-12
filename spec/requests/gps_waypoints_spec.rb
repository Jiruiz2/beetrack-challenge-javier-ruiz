# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'GpsWaypoints', type: :request do
  describe 'POST /api/v1/gps' do
    context 'when latitude is missing' do
      let(:waypoint) do
        {
          'longitude' => -0.5,
          'sent_at' => DateTime.new(2021, 3, 12),  'vehicle_identifier' => 'test'
        }
      end

      it 'returns bad request' do
        expect  do
          post '/api/v1/gps', params: waypoint
        end.to change { GpsWaypoint.count }.by(0)

        expect(response).to have_http_status(:bad_request)
      end
    end

    context 'when longitude is missing' do
      let(:waypoint) do
        {
          'latitude' => 1.5,
          'sent_at' => DateTime.new(2021, 3, 12),  'vehicle_identifier' => 'test'
        }
      end

      it 'returns bad request' do
        expect  do
          post '/api/v1/gps', params: waypoint
        end.to change { GpsWaypoint.count }.by(0)

        expect(response).to have_http_status(:bad_request)
      end
    end

    context 'when sent_at is missing' do
      let(:waypoint) do
        {
          'latitude' => 1.5, 'longitude' => -0.5,
          'vehicle_identifier' => 'test'
        }
      end

      it 'returns bad request' do
        expect  do
          post '/api/v1/gps', params: waypoint
        end.to change { GpsWaypoint.count }.by(0)

        expect(response).to have_http_status(:bad_request)
      end
    end

    context 'when vehicle_identifier is missing' do
      let(:waypoint) do
        {
          'latitude' => 1.5, 'longitude' => -0.5,
          'sent_at' => DateTime.new(2021, 3, 12)
        }
      end

      it 'returns bad request' do
        expect  do
          post '/api/v1/gps', params: waypoint
        end.to change { GpsWaypoint.count }.by(0)

        expect(response).to have_http_status(:bad_request)
      end
    end

    context 'when gps waypoint is duplicated' do
      let(:date) { DateTime.new(2021, 3, 11, 12, 0, 0) }
      let(:identifier) { 'test' }
      let!(:gps_waypoint) { create(:gps_waypoint, sent_at: date, vehicle_identifier: identifier) }
      let(:waypoint) do
        {
          'latitude' => 1.5, 'longitude' => -0.5,
          'sent_at' => date,  'vehicle_identifier' => identifier
        }
      end

      it 'returns bad request' do
        expect  do
          post '/api/v1/gps', params: waypoint
        end.to change { GpsWaypoint.count }.by(0)

        expect(response).to have_http_status(:bad_request)
      end
    end

    context 'when request is correct' do
      let(:waypoint) do
        {
          'latitude' => 1.5, 'longitude' => -0.5,
          'sent_at' => DateTime.new(2021, 3, 12),  'vehicle_identifier' => 'test'
        }
      end

      it 'returns created' do
        expect  do
          post '/api/v1/gps', params: waypoint
        end.to change { GpsWaypoint.count }.by(1)

        expect(response).to have_http_status(:created)
      end
    end
  end
end
