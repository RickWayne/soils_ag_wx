class CreateT411s < ActiveRecord::Migration
  def change
    create_table :t411s do |t|
      t.integer :awon_station_id
      t.date :date
      t.integer :time
      t.float :DMnBatt
      t.float :DToPcpn
      t.float :DAvSol
      t.float :DAvTAir
      t.float :DMxTAir
      t.float :DTxTAir
      t.float :DMnTAir
      t.float :DTnTAir
      t.float :DAvRHum
      t.float :DMxRHum
      t.float :DTxRHum
      t.float :DMnRHum
      t.float :DTnRHum
      t.float :DAvVPre
      t.float :DAvVDef
      t.float :DPkWind
      t.float :DTkWind
      t.float :DAvWind
      t.float :DRsWind
      t.float :DRsDir
      t.float :DDvDir
      t.float :DAvPAR
      t.float :DMxWnd1
      t.float :DTxWnd1
      t.float :DMxDir1
      t.float :DAvTdew
      t.float :DMxTdew
      t.float :DTxTdew
      t.float :DMnTdew
      t.float :DTnTdew
      t.float :DRefET
      t.float :DPctClr

      t.timestamps
    end
  end
end
