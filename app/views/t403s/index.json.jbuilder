json.array!(@t403s) do |t403|
  json.extract! t403, :awon_station_id, :date, :time, :HToPcpn, :HAvSol, :HAvTAir, :HAvRHum, :HAvTS05, :HAvTS10, :HAvTS50, :HPkWind, :HAvWind, :HRsWind, :HRsDir, :HDvDir, :HAvPAR, :HMxWnd1, :HAvTDew
  json.url t403_url(t403, format: :json)
end
