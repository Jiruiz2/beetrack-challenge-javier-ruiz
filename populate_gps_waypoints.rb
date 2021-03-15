# frozen_string_literal: true

require 'httparty'
require 'faker'
require 'pry'

base_url = 'http://beetrack-challenge-javier-ruiz.herokuapp.com'
endpoint = '/api/v1/gps'
url = base_url + endpoint
request_identifier_list = []

(1..200).each do |_|
  json_ask = { 'latitude' => Faker::Number.within(range: 10.0..15.0),
               'longitude' => Faker::Number.within(range: 10.0..15.0),
               'sent_at' => Faker::Time.between(from: DateTime.now - 15, to: DateTime.now).to_s,
               'vehicle_identifier' => Faker::Movie.title }.to_json
  response = HTTParty.post(url, body: json_ask,
                                headers: { 'Content-Type' => 'application/json' })

  request_identifier_list << response.body.delete("\"")
end

request_identifier_list.each do |request_identifier|
  endpoint = "/api/v1/gps_status?request_id=#{request_identifier}"
  url = base_url + endpoint
  result = HTTParty.get(url)
  puts result
end
