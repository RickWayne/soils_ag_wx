json.array!(@regions) do |region|
  json.extract! region, :name, :abbrev
  json.url region_url(region, format: :json)
end
