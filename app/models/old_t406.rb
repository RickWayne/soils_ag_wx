class OldT406 < ActiveRecord::Base
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
      ["HhToPcpn","Total Precipitation (mm)"],
      ["HhAvSol","Average Solar Radiation (W/m2)"],
      ["HhAvTAir","Average Air Temperature (Deg C)"],
      ["HhAvRHum","Average Relative Humidity (Percent)"],
      ["HhAvTS05","Average 2 Inch Soil Temperature (Deg C)"],
      ["HhAvTS10","Average 4 Inch Soil Temperature (Deg C)"],
      ["HhAvTS50","Average 20 Inch Soil Temperature (Deg C)"],
      ["HhPkWind","Peak Wind (m/s)"],
      ["HhAvWind","Average Wind (m/s)"],
      ["HhRsWind","Resultant Wind (m/s)"],
      ["HhRsDir","Resultant Wind Direction (Degrees)"],
      ["HhDvDir","Std. Dev. of Res. Wind Dir. (Degrees)"],
      ["HhAvPAR","Average P.A.R. Radiation (uMoles/(m2s))"],
      ["HhMxWnd1","Maximum One Minute Wind Speed (m/s)"] ,
      ["HhAvTDew","Average Dew Temperature (Deg C)"]
    ]
  end
  
end
