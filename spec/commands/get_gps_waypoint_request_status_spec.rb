# frozen_string_literal: true

require 'rails_helper'

describe GetGpsWaypointRequestStatus do
  def perform(request_id)
    described_class.for(request_id: request_id)
  end

  let(:request_id) { 'test' }

  context 'when status is created' do
    let!(:gps_waypoint) { create(:gps_waypoint, status: 'created', request_identifier: request_id) }

    it 'returns created message and status' do
      expect(perform(request_id)).to eq(['Objeto creado correctamente', :created])
    end
  end

  context 'when status is pending' do
    let!(:gps_waypoint) { create(:gps_waypoint, status: 'pending', request_identifier: request_id) }

    it 'returns pending message and ok status' do
      expect(perform(request_id)).to eq(['Request aún no procesada', :ok])
    end
  end

  context 'when status is bad_request' do
    let!(:gps_waypoint) do create(:gps_waypoint, status: 'bad_request',
                                                 request_identifier: request_id)
    end
    let(:bad_request_message) do 'La fecha ingresada es en el futuro o ya existe la combinación de'\
    ' sent_at y vehicle_identifier'
    end

    it 'returns bad_request message and status' do
      expect(perform(request_id)).to eq([bad_request_message, :bad_request])
    end
  end
end
