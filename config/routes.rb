# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  post '/api/v1/gps' => 'gps_waypoints_api#receive_gps_waypoint'
  get '/api/v1/gps_status' => 'gps_waypoints_api#gps_waypoint_status'
  get '/show' => 'gps_waypoints_map#show'
  root 'gps_waypoints_map#documentation'
end
