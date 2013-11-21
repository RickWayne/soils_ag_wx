class OldAsos < ActiveRecord::Base
  establish_connection adapter: 'mysql',
    host: '127.0.0.1',
    username: 'wayne',
    password: 'agem.Data',
    database: 'asos'
  self.table_name = "asosData"
  
  def self.time_for(date,time)
    Time.utc(date.year,date.month,date.day,time.hour,time.min,time.sec)
  end
  
  def self.translate
    return unless (d = first["Date"])
    start_year = d.year
    stns = AsosStation.all.inject({}) { |hash, station| hash.merge(station.stnid => station[:id]) }
    (start_year..2013).each do |year|
      print "\n#{year}: "
      for stnid in stns.keys
        print " #{stnid}"
        where('ID = ? and Date >= ? and Date <= ?',stnid,Date.civil(year,1,1),Date.civil(year,12,31)).each do |old|
          date = old["Date"]
          AsosDatum.create!(
            date: date, nominal_time: time_for(date,old["NominalTime"]), actual_time: time_for(date,old["ActualTime"]), asos_station_id: stns[stnid],
            t_dew: old["TDew"], t_air: old["TAir"], windspeed: old["WindSpeed"], pressure: old["Pressure"], precip: old["Precip"],
            wind_dir:old["WindDir"]
            )
        end
      end
    end
  end
  
end