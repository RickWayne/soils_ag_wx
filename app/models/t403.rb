class T403 < ActiveRecord::Base
  include Reportable 
  def self.attr_human_readables
    [
      ["stnid","Station Number"],
      ["theDate","Date"],
      ["theTime","Time"],
      ["HToPcpn","Total Precipitation (mm)"],
      ["HAvSol","Average Solar Radiation (W/m2)"],
      ["HAvTAir","Average Air Temperature (Deg C)"],
      ["HAvRHum","Average Relative Humidity (Percent)"],
      ["HAvTS05","Average 2 Inch Soil Temperature (Deg C)"],
      ["HAvTS10","Average 4 Inch Soil Temperature (Deg C)"],
      ["HAvTS50","Average 20 Inch Soil Temperature (Deg C)"],
      ["HPkWind","Peak Wind (m/s)"],
      ["HAvWind","Average Wind (m/s)"],
      ["HRsWind","Resultant Wind (m/s)"],
      ["HRsDir","Resultant Wind Direction (Degrees)"],
      ["HDvDir","Std. Dev. of Res. Wind Dir. (Degrees)"],
      ["HAvPAR","Average P.A.R. Radiation (uMoles/(m2s))"],
      ["HMxWnd1","Maximum One Minute Wind Speed (m/s)"],
      ["HAvTDew","Average Dew Temperature (Deg C)"]
    ]
  end
end
