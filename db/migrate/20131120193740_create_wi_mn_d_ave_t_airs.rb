class CreateWiMnDAveTAirs < ActiveRecord::Migration
  def change
    create_table :wi_mn_d_ave_t_airs do |t|
      t.date :dateStamp
      t.time :timeStamp
      t.float :latitude
      t.float :w980
      t.float :w976
      t.float :w972
      t.float :w968
      t.float :w964
      t.float :w960
      t.float :w956
      t.float :w952
      t.float :w948
      t.float :w944
      t.float :w940
      t.float :w936
      t.float :w932
      t.float :w928
      t.float :w924
      t.float :w920
      t.float :w916
      t.float :w912
      t.float :w908
      t.float :w904
      t.float :w900
      t.float :w896
      t.float :w892
      t.float :w888
      t.float :w884
      t.float :w880
      t.float :w876
      t.float :w872
      t.float :w868
      t.float :w864
      t.float :w860

      t.timestamps
    end
  end
end
