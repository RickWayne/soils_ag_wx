json.array!(@t412s) do |t412|
  json.extract! t412, :awon_station_id, :date, :time, :DAvTS05, :DMxTS05, :DTxTS05, :DMnTS05, :DTnTS05, :DAvTS10, :DMxTS10, :DTxTS10, :DMnTS10, :DTnTS10, :DAvTS50, :DMxTS50, :DTxTS50, :DMnTS50, :DTnTS50, :DAvTS1m
  json.url t412_url(t412, format: :json)
end
