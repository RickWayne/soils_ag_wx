require File.join(File.dirname(__FILE__),'..','config','environment.rb')
require 'agwx_grids'

include AgwxGrids

grid_classes = {'TAvg' => WiMnDAveTAir, 'TMin' => WiMnDMinTAir, 'TMax' => WiMnDMaxTAir, 'ET' => WiMnDet, 'VAvg' => WiMnDAveVapr }

def date_for(year,doy)
  Date.civil(year,1,1) + doy - 1
end

def longitude_cols(grid_class)
  grid_class.new.attributes.keys.select {|attr_name| attr_name.to_s =~ /^w[\d]{3}$/}.sort { |a, b| b <=> a }
end

unless (grid_filename = ARGV[0]) && (grid_filename =~ /WIMN(.+)([\d]{4})$/)
  puts "usage: import_grid.rb grid_filename, e.g. import_grid.rb WIMNTAvg2013"
  puts "you supplied #{ARGV[0]}"
  exit -1
end

unless (grid_activerecord_class = grid_classes[$1])
  puts "No class/table found for #{$1}"
  exit -1
end

unless (year = $2.to_i)
  puts "No year parseable from path, tried #{$2}"
  exit -1
end

grid = Grid.new(grid_filename,Grid::DAILY)
long_cols = longitude_cols(grid_activerecord_class)

# Make a list of all the layers in this grid that aren't in (or are incomplete in) the database
doys = grid.layer_list.inject([]) do |arr,doy|
  # Number of latitude rows for each date should == rows in a layer
  if grid_activerecord_class.where(date: date_for(year,doy)).count < grid.layer(doy).rows.size
    arr << doy
  else
    arr
  end
end


# for each doy
doys.each do |doy|
  layer = grid.layer(doy)
  date = date_for(year,doy)
  layer.rows.each_with_index do |row,index|
    latitude = grid.latitude_for(index)
    db_row = grid_activerecord_class.new date: date, latitude: latitude
    (0..row.size-1).each do |col_index|
      db_row[long_cols[col_index]] = row[col_index]
    end
    db_row.save!
  end
end
  