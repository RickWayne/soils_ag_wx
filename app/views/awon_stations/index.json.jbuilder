json.array!(@awon_stations) do |awon_station|
  json.extract! awon_station, :awon_station_id, :name, :abbrev, :county, :latitude, :longitude, :status, :wind, :humidity, :has_401, :has_403, :has_411, :has_412, :has_404
  json.url awon_station_url(awon_station, format: :json)
end
