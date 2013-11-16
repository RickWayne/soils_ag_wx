class CreateT406s < ActiveRecord::Migration
  def change
    create_table :t406s do |t|
      t.integer :awon_station_id
      t.date :date
      t.integer :time
      t.float :HhToPcpn
      t.float :HhAvSol
      t.float :HhAvTAir
      t.float :HhAvRHum
      t.float :HhAvTS05
      t.float :HhAvTS10
      t.float :HhAvTS50
      t.float :HhPkWind
      t.float :HhAvWind
      t.float :HhRsWind
      t.float :HhRsDir
      t.float :HhDvDir
      t.float :HhAvPAR
      t.float :HhMxWnd1
      t.float :HhAvTDew

      t.timestamps
    end
  end
end
