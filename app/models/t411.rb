class T411 < ActiveRecord::Base
  include Reportable
  include Assessable
  belongs_to :awon_station
  def self.attr_human_readables
    [                                                  
      ["date","Date"],
      ["time","Time"],
      ["DMnBatt","Minimum Battery Voltage (Volts)"],
      ["DToPcpn","Total Precipitation (mm)"],
      ["DAvSol","Average Solar Radiation (W/m2)"],
      ["DAvTAir","Average Air Temperature (Deg C)"],
      ["DMxTAir","Maximum Air Temperature (Deg C)"],
      ["DTxTAir","Time of Max Air Temp (HHMM)"],
      ["DMnTAir","Minimum Air Temperature (Deg C)"],
      ["DTnTAir","Time of Min Air Temp (HHMM)"],
      ["DAvRHum","Average Relative Humidity (Percent)"],
      ["DMxRHum","Maximum Relative Humidity (Percent)"],
      ["DTxRHum","Time of Max. Rel. Hum. (HHMM)"],
      ["DMnRHum","Minimum Relative Humidity (Percent)"],
      ["DTnRHum","Time of Min. Rel. Hum. (HHMM)"],
      ["DAvVPre","Average Vapor Pressure (kPa)"],
      ["DAvVDef","Average Vap. Pres. Deficit (kPa)"],
      ["DPkWind","Peak Wind (m/s)"],
      ["DTkWind","Time of the Peak Wind (HHMM)"],
      ["DAvWind","Average Wind (m/s)"],
      ["DRsWind","Resultant Wind (m/s)"],
      ["DRsDir","Resultant Wind Direction (Degrees)"],
      ["DDvDir","Std. Dev. of Res. Wind Dir. (Degrees)"],
      ["DAvPAR","Average Phot. Active Region Rad. (uMoles/(m2s))"],
      ["DMxWnd1","One Minute Maximum Wind (m/s)"],
      ["DTxWnd1","Time of 1 Min. Max. Wind (HHMM)"],
      ["DMxDir1","Dir of 1 Min. Max. Wind (Degrees)"],
      ["DAvTdew","Average Dew Temperature (Deg C)"],
      ["DMxTdew","Maximum Dew Temperature (Deg C)"],
      ["DTxTdew","Time of Max. Dew Temp. (HHMM)"],
      ["DMnTdew","Minimum Dew Temperature (Deg C)"],
      ["DTnTdew","Time of Min. Dew Temp. (HHMM)"],
      ["DRefET","Reference Evapo-Transpiration (Inches)"],
      ["DPctClr","Percent Clear Sky (Percent)"]
    ]
  end
end
