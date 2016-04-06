class WiMnDet < ActiveRecord::Base
  include GridDB
  include Assessable

  def self.date_sym
    :date
  end

  def self.daily_series(start_date, end_date, long, lat)
    long *= -1 if long < 0
    url = "http://localhost:8080/evapotranspirations?lat=#{lat}&long=#{long}&start_date=#{start_date}&end_date=#{end_date}"
    response = HTTParty.get(url)
    body = JSON.parse(response.body)
    body.map { |h| [h['date'], h['value']] }.to_h
  end
end
