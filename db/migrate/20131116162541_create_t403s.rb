class CreateT403s < ActiveRecord::Migration
  def change
    create_table :t403s do |t|
      t.integer :awon_station_id
      t.date :date
      t.integer :time
      t.float :HToPcpn
      t.float :HAvSol
      t.float :HAvTAir
      t.float :HAvRHum
      t.float :HAvTS05
      t.float :HAvTS10
      t.float :HAvTS50
      t.float :HPkWind
      t.float :HAvWind
      t.float :HRsWind
      t.float :HRsDir
      t.float :HDvDir
      t.float :HAvPAR
      t.float :HMxWnd1
      t.float :HAvTDew

      t.timestamps
    end
  end
end
