json.array!(@awon_record_types) do |awon_record_type|
  json.extract! awon_record_type, :rec_id, :rec_name
  json.url awon_record_type_url(awon_record_type, format: :json)
end
