json.array!(@t401s) do |t401|
  json.extract! t401, :awon_station_id, :date, :time, :M5Pcpn, :M5Pcpn2, :M5Wind
  json.url t401_url(t401, format: :json)
end
