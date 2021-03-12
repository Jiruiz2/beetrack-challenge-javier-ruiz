# frozen_string_literal: true

FactoryBot.define do
  factory :gps_waypoint do
    latitude { Faker::Number.within(range: -10.0..10.0) }
    longitude { Faker::Number.within(range: -10.0..10.0) }
    sent_at { Faker::Date.between(from: '2014-09-23', to: '2014-09-25') }
    sequence(:vehicle_identifier) { |seq| "ABDCEFG#{seq}" }
  end
end
