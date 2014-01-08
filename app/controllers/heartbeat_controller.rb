class HeartbeatController < ApplicationController
  def index
    # @sections = ['awon','asos','hyd','dd','et','insol','ping','webapps']
    @sections = ['awon','asos']
  end

  def awon
    @awon_res = {}
    [4751,4781].each do |stnid|
      awon_station = AwonStation.where(stnid: stnid).first
      puts "************"
      puts awon_station.inspect
      [T411,T412,T406].each do |awon_class|
        @awon_res["#{awon_station.abbrev}_#{awon_class.to_s}"] = awon_class.hasYesterday(['awon_station_id=?',awon_station[:id]])
      end
    end
    render partial: 'awon'
  end

  def asos
    stn_id = AsosStation.where(stnid: 'KAIG').first[:id]
    @asos_res = {'KAIG' => AsosDatum.hasYesterday(['asos_station_id = ?',stn_id])}
    render partial: 'asos'
  end

  def hyd
    render partial: 'hyd'
  end

  def dd
    render partial: 'dd'
  end

  def et
    render partial: 'et'
  end

  def insol
    render partial: 'insol'
  end

  def ping
    render partial: 'ping'
  end

  def webapps
    render partial: 'webapps'
  end
end
