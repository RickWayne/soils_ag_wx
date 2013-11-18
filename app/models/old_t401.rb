class OldT401 < ActiveRecord::Base
    establish_connection adapter: 'mysql',
      host: '127.0.0.1',
      username: 'wayne',
      password: 'agem.Data',
      database: 'aws'
    self.to_s =~ /([\d]{3})$/
    self.table_name = "t_#{$1}"

    include Reportable
  
  def self.attr_human_readables
    [
      ["stnid","Station Number"],
      ["theDate","Date"],
      ["theTime","Time"],
      ["M5Pcpn","Five-Minute Precipitation (mm)"],
      ["M5Pcpn2","5-Min Precip Bucket 2 (mm)"],
      ["M5Wind","Five-Minute Wind (m/s)"]
    ]
  end
end
