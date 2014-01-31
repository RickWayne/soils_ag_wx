class CreateDegreeDayStations < ActiveRecord::Migration
  def change
    create_table :degree_day_stations do |t|
      t.string :abbrev
      t.string :name
      t.float :latitude
      t.float :longitude
      t.timestamps
    end
    # Fill the Degree Day Station model with the stations in ~asig/products/lists/cpsb.list
    dd_stns = <<-END
    DBQ 42.50 -90.69 Dubuque, IA
    LON 43.18 -90.20 Lone Rock 
    BEL 42.52 -89.02 Beloit
    MAD 43.08 -89.39 Madison
    SUL 43.01 -88.59 Sullivan
    JUN 43.41 -88.70 Juneau
    WAK 43.01 -88.24 Waukesha
    HAR 43.32 -88.39 Hartford
    RAC 42.73 -87.81 Racine
    MIL 43.06 -87.97 Milwaukee
    GRB 44.52 -87.99 Green Bay
    BFL 44.11 -89.80 Big Flats
    PED 44.35 -89.85 Port Edwards
    LCR 43.83 -91.23 La Crosse
    EAU 44.82 -91.49 Eau Claire
    CMB 45.54 -92.02 Cumberland
    BAY 46.81 -90.82 Bayfield
    WAU 44.96 -89.64 Wausau
    MED 45.14 -90.35 Medford
    HAN 44.13 -89.52 Hancock
    APL 44.27 -88.40 Appleton
    CRN 45.57 -88.90 Crandon
    CRV 45.23 -88.01 Crivitz
    FLD 43.75 -88.49 Fond Du Lac
    END

    dd_stns.split("\n").each do |line|
      line =~ /(.{3})[\s]+([\d]{2}\.[\d]{2})[\s]+(-[\d]{2}\.[\d]{2})[\s]+(.+)$/
      DegreeDayStation.create! abbrev: $1, latitude: $2.to_f, longitude: $3.to_f, name: $4
    end
    
  end
end
