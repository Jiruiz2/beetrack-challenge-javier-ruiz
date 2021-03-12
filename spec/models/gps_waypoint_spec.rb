# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GpsWaypoint, type: :model do
  it { is_expected.to validate_presence_of(:latitude) }
  it { is_expected.to validate_presence_of(:longitude) }
  it { is_expected.to validate_presence_of(:sent_at) }
  it { is_expected.to validate_presence_of(:vehicle_identifier) }
end
