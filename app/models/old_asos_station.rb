class OldAsosStation < ActiveRecord::Base
  establish_connection adapter: 'mysql',
    host: '127.0.0.1',
    username: 'wayne',
    password: 'agem.Data',
    database: 'asos'
  self.table_name = "asosStation"
  
def self.translate
  all.each do |old|
    AsosStation.create!(
      stnid: old["stnID"], state: old["stnState"], name: old["stnName"], type: old["stnType"],
      latitude: old["stnLat"], longitude: old["stnLong"],
     )
  end
end