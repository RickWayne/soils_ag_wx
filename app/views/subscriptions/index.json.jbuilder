json.array!(@subscriptions) do |subscription|
  json.extract! subscription, :name, :subscriber_id, :latitude, :longitude, :product_id
  json.url subscription_url(subscription, format: :json)
end
