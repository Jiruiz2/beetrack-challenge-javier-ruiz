# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  post '/api/v1/gps' => 'gps_waypoints#receive_gps_waypoint'
  get '/show' => 'map_gps_view#show'
  root 'map_gps_view#documentation'
end
