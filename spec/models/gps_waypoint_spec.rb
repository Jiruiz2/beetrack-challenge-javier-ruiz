# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GpsWaypoint, type: :model do
  before do
    Timecop.freeze(DateTime.new(2021, 3, 12, 12, 0, 0))
  end

  after do
    Timecop.return
  end

  it { is_expected.to validate_presence_of(:latitude) }
  it { is_expected.to validate_presence_of(:longitude) }
  it { is_expected.to validate_presence_of(:sent_at) }
  it { is_expected.to validate_presence_of(:vehicle_identifier) }

  context 'when gps waypoint is duplicated' do
    let(:date) { '2021/03/11 12:00:00' }
    let(:identifier) { 'test' }
    let!(:gps_waypoint) { create(:gps_waypoint, sent_at: date, vehicle_identifier: identifier) }

    it 'does not create the instance' do
      expect(build(:gps_waypoint, sent_at: date,
                                  vehicle_identifier: identifier)).not_to be_valid
    end
  end

  context 'when sent_date is on the future' do
    let(:date) { '2021/03/15 12:00:00' }
    let(:identifier) { 'test' }

    it 'does not create the instance' do
      expect(build(:gps_waypoint, sent_at: date,
                                  vehicle_identifier: identifier)).not_to be_valid
    end
  end
end
