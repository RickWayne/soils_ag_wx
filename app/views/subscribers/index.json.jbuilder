json.array!(@subscribers) do |subscriber|
  json.extract! subscriber, :name, :email, :confirmed
  json.url subscriber_url(subscriber, format: :json)
end
