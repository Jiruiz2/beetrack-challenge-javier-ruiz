# frozen_string_literal: true

require 'rails_helper'

describe ReceiveGpsWaypoint do
  def perform(params)
    described_class.for(params: params)
  end

  before do
    ActiveJob::Base.queue_adapter = :test
  end

  context 'when request is correct' do
    let(:params) do
      {
        'longitude' => -0.5, 'latitude' => 1.5,
        'sent_at' => '2021/3/11 12:00:00',  'vehicle_identifier' => 'test'
      }
    end
    let(:request_identifier) { Digest::MD5.hexdigest("id::1") }

    it 'executes job and creates the instance' do
      expect do
        perform(params)
      end.to have_enqueued_job(SaveGpsWaypointJob).and change { GpsWaypoint.count }.by(1)
    end

    it 'returns request_identifier and ok status' do
      expect(perform(params)).to eq([request_identifier, :ok])
    end
  end

  context 'when latitude is missing' do
    let(:params) do
      {
        'longitude' => -0.5,
        'sent_at' => '2021/3/11 12:00:00',  'vehicle_identifier' => 'test'
      }
    end
    let(:error_message) { { latitude: ["can't be blank"] } }

    it 'does not create the instance and does not execute the job' do
      expect { perform(params) }.to change { GpsWaypoint.count }.by(0)
    end

    it 'returns error and bad_request status' do
      expect(perform(params)).to eq([error_message, :bad_request])
    end
  end

  context 'when vehicle_identifier is missing' do
    let(:params) do
      {
        'longitude' => -0.5, 'latitude' => 1.5,
        'sent_at' => '2021/3/11 12:00:00'
      }
    end
    let(:error_message) { { vehicle_identifier: ["can't be blank"] } }

    it 'does not create the instance and does not execute the job' do
      expect { perform(params) }.to change { GpsWaypoint.count }.by(0)
    end

    it 'returns error and bad_request status' do
      expect(perform(params)).to eq([error_message, :bad_request])
    end
  end

  context 'when longitude is missing' do
    let(:params) do
      {
        'latitude' => -0.5,
        'sent_at' => '2021/3/11 12:00:00',  'vehicle_identifier' => 'test'
      }
    end
    let(:error_message) { { longitude: ["can't be blank"] } }

    it 'does not create the instance and does not execute the job' do
      expect { perform(params) }.to change { GpsWaypoint.count }.by(0)
    end

    it 'returns error and bad_request status' do
      expect(perform(params)).to eq([error_message, :bad_request])
    end
  end

  context 'when sent_at is missing' do
    let(:params) do
      {
        'longitude' => -0.5, 'latitude' => 1.5,
        'vehicle_identifier' => 'test'
      }
    end
    let(:error_message) { { sent_at: ["can't be blank"] } }

    it 'does not create the instance and does not execute the job' do
      expect { perform(params) }.to change { GpsWaypoint.count }.by(0)
    end

    it 'returns error and bad_request status' do
      expect(perform(params)).to eq([error_message, :bad_request])
    end
  end
end
