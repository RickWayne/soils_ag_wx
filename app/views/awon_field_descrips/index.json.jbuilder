json.array!(@awon_field_descrips) do |awon_field_descrip|
  json.extract! awon_field_descrip, :rec_id, :column_num, :field_name, :field_abbrev, :units, :decimals
  json.url awon_field_descrip_url(awon_field_descrip, format: :json)
end
