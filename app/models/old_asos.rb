class OldAsos < ActiveRecord::Base
  establish_connection adapter: 'mysql',
    host: '127.0.0.1',
    username: 'wayne',
    password: 'agem.Data',
    database: 'asos'
  self.table_name = "asosData"
  
  def self.translate
    start_year = first.date.year
    stns = AsosStation.all.inject({}) { |hash, station| hash.merge {station.stnid => station[:id]} }
    (start_year..2013).each do |year|
      where('Date >= ? and Date <= ?',Date.civil(year,1,1),Date.civil(year,12,31)).each do |old|
        station_id = stns[old.send('ID')]
        AsosDatum.create!(
          date: old["Date"], nominal_time: old["NominalTime"], actual_time: old["ActualTime"], asos_station_id: station_id,
          t_dew: old["TDew"], t_air: old["TAir"], windspeed: old["WindSpeed"], pressure: old["Pressure"], precip: old["Precip"],
          wind_dir:old["WindDir"]
          )
      end
    end
  end
  
end

class OldAsosStation < ActiveRecord::Base
  establish_connection adapter: 'mysql',
    host: '127.0.0.1',
    username: 'wayne',
    password: 'agem.Data',
    database: 'asos'
  self.table_name = "asosStations"
  
  def self.translate
    all.each do |old|
      AsosStation.create!(
        stnid: old.stnID, state: old["stnState"], name: old["stnName"], type: old["stnType"],
        latitude: old["stnLat"], longitude: old["stnLong"],
        )
    end
  end
end