json.array!(@asos_stations) do |asos_station|
  json.extract! asos_station, :stnid, :state, :name, :type, :latitude, :longitude
  json.url asos_station_url(asos_station, format: :json)
end
