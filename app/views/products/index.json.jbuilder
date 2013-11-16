json.array!(@products) do |product|
  json.extract! product, :name, :data_table_name, :type
  json.url product_url(product, format: :json)
end
