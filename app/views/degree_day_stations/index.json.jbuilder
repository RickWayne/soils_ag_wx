json.array!(@degree_day_stations) do |degree_day_station|
  json.extract! degree_day_station, :abbrev, :name, :latitude, :longitude
  json.url degree_day_station_url(degree_day_station, format: :json)
end
