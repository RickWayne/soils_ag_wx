json.array!(@t411s) do |t411|
  json.extract! t411, :awon_station_id, :date, :time, :DMnBatt, :DToPcpn, :DAvSol, :DAvTAir, :DMxTAir, :DTxTAir, :DMnTAir, :DTnTAir, :DAvRHum, :DMxRHum, :DTxRHum, :DMnRHum, :DTnRHum, :DAvVPre, :DAvVDef, :DPkWind, :DTkWind, :DAvWind, :DRsWind, :DRsDir, :DDvDir, :DAvPAR, :DMxWnd1, :DTxWnd1, :DMxDir1, :DAvTdew, :DMxTdew, :DTxTdew, :DMnTdew, :DTnTdew, :DRefET, :DPctClr
  json.url t411_url(t411, format: :json)
end
