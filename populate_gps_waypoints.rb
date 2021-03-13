# frozen_string_literal: true

require 'httparty'
require 'faker'

url = 'https://beetrack-challenge-javier-ruiz.herokuapp.com/api/v1/gps'

(1..100).each do |_|
  json_ask = { 'latitude' => Faker::Number.within(range: 10.0..15.0),
               'longitude' => Faker::Number.within(range: 10.0..15.0),
               'sent_at' => Faker::Time.between(from: DateTime.now - 15, to: DateTime.now).to_s,
               'vehicle_identifier' => Faker::Movie.title }.to_json

  result = HTTParty.post(url,
                         body: json_ask,
                         headers: { 'Content-Type' => 'application/json' })

  puts result
end
