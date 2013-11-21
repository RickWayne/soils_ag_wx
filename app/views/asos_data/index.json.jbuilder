json.array!(@asos_data) do |asos_datum|
  json.extract! asos_datum, :date, :nominal_time, :actual_time, :asos_station_id, :t_dew, :t_air, :windspeed, :pressure, :precip, :wind_dir
  json.url asos_datum_url(asos_datum, format: :json)
end
