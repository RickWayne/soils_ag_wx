class OldT412 < ActiveRecord::Base
  establish_connection adapter: 'mysql',
    host: '127.0.0.1',
    username: 'wayne',
    password: 'agem.Data',
    database: 'aws'
  self.to_s =~ /([\d]{3})$/
  self.table_name = "t_#{$1}"
  def self.attr_human_readables
    [                                                  
      ["stnid","Station Number"],
      ["theDate","Date"],
      ["theTime","Time"],
      ["DAvTS05","2 Inch Average Soil Temp. (Deg C)"],
      ["DMxTS05","2 Inch Maximum Soil Temp. (Deg C)"],
      ["DTxTS05","2 Inch Time Max. Soil Temp. (HHMM)"],
      ["DMnTS05","2 Inch Minimum Soil Temp. (Deg C)"],
      ["DTnTS05","2 Inch Time Min. Soil Temp. (HHMM)"],
      ["DAvTS10","4 Inch Average Soil Temp. (Deg C)"],
      ["DMxTS10","4 Inch Maximum Soil Temp. (Deg C)"],
      ["DTxTS10","4 Inch Time Max. Soil Temp. (HHMM)"],
      ["DMnTS10","4 Inch Minimum Soil Temp. (Deg C)"],
      ["DTnTS10","4 Inch Time Min. Soil Temp. (HHMM)"],
      ["DAvTS50","20 Inch Average Soil Temp. (Deg C)"],
      ["DMxTS50","20 Inch Maximum Soil Temp. (Deg C)"],
      ["DTxTS50","20 Inch Time Max. Soil Temp. (HHMM)"],
      ["DMnTS50","20 Inch Minimum Soil Temp. (Deg C)"],
      ["DTnTS50","20 Inch Time Min. Soil Temp. (HHMM)"],
      ["DAvTS1m","40 Inch Average Soil Temp. (Deg C)"]
    ]
  end
  
end
