class T401 < ActiveRecord::Base
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
