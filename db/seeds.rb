# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Fill the WiMnDAveTAirs grid with 2002 data (clone of import_grid.rb)

min_path = File.join(File.dirname(__FILE__),'WIMNTMin2002')
WiMnDAveTAir.import_grid(min_path,2002)
Product.create! name: 'Reference Evapotranspiration', data_table_name: 'wi_mn_dets',
  type: 'GridProduct', subscribable: true, default_doy_start: 105, default_doy_end: 273
Product.create! name: 'Cranberry Consumptive Water Use', data_table_name: 'wi_mn_dets',
  type: 'GridProduct', subscribable: true, default_doy_start: 105, default_doy_end: 273
