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
      print "\n#{year}: "
      for stnid in stns.keys
        print " #{stnid}"
        where('ID = ? and Date >= ? and Date <= ?',stnid,Date.civil(year,1,1),Date.civil(year,12,31)).each do |old|
          AsosDatum.create!(
            date: old["Date"], nominal_time: old["NominalTime"], actual_time: old["ActualTime"], asos_station_id: stns[stnid],
            t_dew: old["TDew"], t_air: old["TAir"], windspeed: old["WindSpeed"], pressure: old["Pressure"], precip: old["Precip"],
            wind_dir:old["WindDir"]
            )
        end
      end
    end
  end
  
end