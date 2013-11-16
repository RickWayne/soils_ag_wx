json.array!(@t406s) do |t406|
  json.extract! t406, :awon_station_id, :date, :time, :HhToPcpn, :HhAvSol, :HhAvTAir, :HhAvRHum, :HhAvTS05, :HhAvTS10, :HhAvTS50, :HhPkWind, :HhAvWind, :HhRsWind, :HhRsDir, :HhDvDir, :HhAvPAR, :HhMxWnd1, :HhAvTDew
  json.url t406_url(t406, format: :json)
end
