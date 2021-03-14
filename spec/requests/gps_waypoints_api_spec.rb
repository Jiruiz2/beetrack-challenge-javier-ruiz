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
    let(:response_message) { "\"Tu solicitud ha sido recibida correctamente\"" }

    it 'render json response and has created status' do
      post '/api/v1/gps', params: params

      expect(response.body).to eq(response_message)
      expect(response).to have_http_status(:created)
    end
  end
end
