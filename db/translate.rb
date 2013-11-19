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

def migrate_rec_type(old_class,new_class,start_year=1985)
  stns = AwonStation.all
  puts "#{old_class} to #{new_class}"
  ii=0
  stns.each do |stn|
    puts "\n\n#{stn.name}"
    (start_year..2013).each do |year|
      puts "  #{year}"
      old_class.where("theDate >= ? and theDate <= ? and stnid = ?","#{year}-01-01","#{year}-12-31",stn.stnid).each do |rec|
        translate(rec,new_class)
        print ".";$stdout.flush if (ii > 200 && ii%200 == 0)
        ii+=1
      end
    end
  end
end