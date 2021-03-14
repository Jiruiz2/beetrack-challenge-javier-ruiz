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

  context 'when gps waypoint is duplicated' do
    let(:date) { DateTime.new(2021, 3, 10) }
    let(:identifier) { 'test' }
    let!(:gps_waypoint1) do
      create(:gps_waypoint, sent_at: date, vehicle_identifier: identifier,
                            status: 'created')
    end
    let!(:gps_waypoint2) { create(:gps_waypoint, sent_at: date, vehicle_identifier: identifier) }

    it 'changes status to bad_request' do
      expect { perform(gps_waypoint2) }.to change { gps_waypoint2.status }.from('pending')
                                                                          .to('bad_request')
    end
  end

  context 'when sent_date is on the future' do
    let(:date) { DateTime.new(2021, 3, 20) }
    let(:identifier) { 'test' }
    let!(:gps_waypoint) { create(:gps_waypoint, sent_at: date, vehicle_identifier: identifier) }

    it 'changes status to bad_request' do
      expect { perform(gps_waypoint) }.to change { gps_waypoint.status }.from('pending')
                                                                        .to('bad_request')
    end
  end

  context 'when request is correct' do
    let(:date) { DateTime.new(2021, 3, 10) }
    let(:identifier) { 'test' }
    let!(:gps_waypoint) { create(:gps_waypoint, sent_at: date, vehicle_identifier: identifier) }

    it 'changes status to created' do
      expect { perform(gps_waypoint) }.to change { gps_waypoint.status }.from('pending')
                                                                        .to('created')
    end
  end
end
