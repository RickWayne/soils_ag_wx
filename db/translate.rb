def translate(old_rec,new_class)
  new_rec = new_class.new
  # finder = "SELECT * FROM uwex_agwx_devel.awon_stations where stnid=#{old_rec.stnid}"
  # new_rec.awon_station = AwonStation.first
  new_rec.awon_station = AwonStation.find_by_stnid(old_rec.stnid)
  new_rec.date = old_rec.theDate
  new_rec.time = old_rec.theTime
  old_hash = old_rec.attributes.clone
  old_hash.delete("stnid")
  old_hash.delete("theDate")
  old_hash.delete("theTime")
  old_hash.reject! {|key,val| key == nil}
  new_rec.update_attributes(old_hash)
end
