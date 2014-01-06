json.array!(@hyds) do |hyd|
  json.extract! hyd, :date, :stn, :county, :name, :max_temp, :min_temp, :pcpn, :new_snow, :snow_depth
  json.url hyd_url(hyd, format: :json)
end
