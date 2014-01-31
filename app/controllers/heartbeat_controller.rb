require 'net/http'
RRAF_IMAGE_URL = '/geoserver/wms?LAYERS=mmas%3Arf_map_0&STYLES=&SRS=EPSG%3A900913&FORMAT=image%2Fgif&TILED=false&TRANSPARENT=TRUE&SERVICE=WMS&VERSION=1.1.1&REQUEST=GetMap&BBOX=-10400000.0,5150000,-9680000.0,5950000.0&WIDTH=512&HEIGHT=512'
MADISON_POPUP_URL = '/geoserver/wms?REQUEST=GetFeatureInfo&EXCEPTIONS=application%2Fvnd.ogc.se_xml&BBOX=-10480441.927412%2C5205663.525481%2C-9608448.308856%2C5988378.695012&X=435&Y=537&INFO_FORMAT=text%2Fplain&QUERY_LAYERS=mmas%3Arf_map_0&FEATURE_COUNT=50&Layers=mmas%3Arf_map_0&Styles=&Srs=EPSG%3A900913&WIDTH=713&HEIGHT=640&format=image%2Fpng'
class HeartbeatController < ApplicationController
  def index
    # @sections = ['awon','asos','hyd','dd','et','insol','ping','webapps']
    @sections = ['awon','asos','webapps','et','asos_grids']
    @rraf_image_url = RRAF_IMAGE_URL
    @madison_popup_url = MADISON_POPUP_URL
  end

  def awon
    @awon_res = {}
    [4751,4781].each do |stnid|
      awon_station = AwonStation.where(stnid: stnid).first
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
    # Have to specify the date for this, otherwise it defaults to a Time -- may need to fix that
    @et_res = {'44.0,-92.0' => WiMnDet.hasYesterday(['latitude = ? and w920 is not null',44.0],Date.today - 1)}
    render partial: 'et'
  end
  
  def asos_grids
    @asos_grid_res = 
      [WiMnDAveTAir,WiMnDMinTAir,WiMnDMaxTAir,WiMnDAveVapr].inject({}) do |hash,grid_class|
        hash.merge( {grid_class.to_s => grid_class.hasYesterday(['latitude = ? and w920 is not null',44.0],Date.today - 1)} )
      end
    render partial: 'asos_grids'
  end

  def insol
    render partial: 'insol'
  end

  def ping
    render partial: 'ping'
  end

  def webapps
    @apps = {
      # 'wisp'      => { server: 'wisp.cals.wisc.edu',  url: '/'},
      '590 page'       => { server: 'gis.soils.wisc.edu',  url: '/app/maps'},
      'RRAF page'      => { server: 'gis.soils.wisc.edu',  url: '/app/events/runoff_forecast'},
      'RRAF Map Tile'  => { server: 'gis.soils.wisc.edu',  url: RRAF_IMAGE_URL},
      'RRAF Popup'     => { server: 'gis.soils.wisc.edu',  url: MADISON_POPUP_URL},
    }
    @urls = @apps.inject({}) do |hash,(key,param_hash)|
      puts "*********************"
      puts hash.inspect
      puts key.inspect
      puts param_hash.inspect
      hash.merge({key => "http://#{param_hash[:server]}/#{param_hash[:url]}"})
      # {'wisp' => 'http://wisp.cals.wisc.edu//', '590 page' => etc.}
    end
    
    # @webapp_results = apps.inject({}) do |hash,(key,addr_hash)|
    #   begin
    #     h = Net::HTTP.new(addr_hash[:server],80)
    #     resp = h.get(addr_hash[:url])
    #     raise "resp nil" unless resp
    #   rescue Exception => e
    #     logger.warn "Heartbeat#webapps: " + e.to_s
    #     code = 500
    #   end
    #   hash.merge({key => resp.code.to_i == 200})
    # end
    # render partial: 'webapps', layout: 'application.html.erb'
  end
  
end
