# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SaveGpsWaypointJob, type: :job do
  def perform(params)
    described_class.perform_now(params)
  end

  before do
    Timecop.freeze(DateTime.new(2021, 3, 12, 12, 0, 0))
  end

  after do
    Timecop.return
  end

  describe 'POST /api/v1/gps' do
    context 'when latitude is missing' do
      let(:params) do
        {
          'longitude' => -0.5,
          'sent_at' => '2021/3/11 12:00:00',  'vehicle_identifier' => 'test'
        }
      end
      let(:response) { "{\"latitude\":[\"can't be blank\"]}" }
      let(:status) { :bad_request }

      it 'returns error and bad request status' do
        expect(perform(params)).to eq([response, status])
      end

      it 'does not create a GpsWaypoint instance' do
        expect  { perform(params) }.to change { GpsWaypoint.count }.by(0)
      end
    end

    context 'when longitude is missing' do
      let(:params) do
        {
          'latitude' => 1.5,
          'sent_at' => '2021/3/11 12:00:00',  'vehicle_identifier' => 'test'
        }
      end
      let(:response) { "{\"longitude\":[\"can't be blank\"]}" }
      let(:status) { :bad_request }

      it 'returns error and bad request status' do
        expect(perform(params)).to eq([response, status])
      end

      it 'does not create a GpsWaypoint instance' do
        expect  { perform(params) }.to change { GpsWaypoint.count }.by(0)
      end
    end

    context 'when sent_at is missing' do
      let(:params) do
        {
          'latitude' => 1.5, 'longitude' => -0.5,
          'vehicle_identifier' => 'test'
        }
      end
      let(:response) { "{\"sent_at\":[\"can't be blank\"]}" }
      let(:status) { :bad_request }

      it 'returns error and bad request status' do
        expect(perform(params)).to eq([response, status])
      end

      it 'does not create a GpsWaypoint instance' do
        expect  { perform(params) }.to change { GpsWaypoint.count }.by(0)
      end
    end

    context 'when vehicle_identifier is missing' do
      let(:params) do
        {
          'latitude' => 1.5, 'longitude' => -0.5,
          'sent_at' => '2021/3/11 12:00:00'
        }
      end
      let(:response) { "{\"vehicle_identifier\":[\"can't be blank\"]}" }
      let(:status) { :bad_request }

      it 'returns error and bad request status' do
        expect(perform(params)).to eq([response, status])
      end

      it 'does not create a GpsWaypoint instance' do
        expect  { perform(params) }.to change { GpsWaypoint.count }.by(0)
      end
    end

    context 'when gps waypoint is duplicated' do
      let(:date) { DateTime.new(2021, 3, 11, 12, 0, 0) }
      let(:identifier) { 'test' }
      let!(:gps_waypoint) { create(:gps_waypoint, sent_at: date, vehicle_identifier: identifier) }
      let(:params) do
        {
          'latitude' => 1.5, 'longitude' => -0.5,
          'sent_at' => date,  'vehicle_identifier' => identifier
        }
      end
      let(:response) { "{\"vehicle_identifier\":[\"Gps Waypoint request is duplicated\"]}" }
      let(:status) { :bad_request }

      it 'returns error and bad request status' do
        expect(perform(params)).to eq([response, status])
      end

      it 'does not create a GpsWaypoint instance' do
        expect  { perform(params) }.to change { GpsWaypoint.count }.by(0)
      end
    end

    context 'when request is correct' do
      let(:params) do
        {
          'latitude' => 1.5, 'longitude' => -0.5,
          'sent_at' => '2021/3/11 12:00:00',  'vehicle_identifier' => 'test'
        }
      end
      let(:response) { 'Tu solicitud ha sido recibida correctamente'.to_json }
      let(:status) { :created }

      it 'returns successful message and created status' do
        expect(perform(params)).to eq([response, status])
      end

      it 'does create a GpsWaypoint instance' do
        expect { perform(params) }.to change { GpsWaypoint.count }.by(1)
      end
    end
  end
end
