class DatestampToDate < ActiveRecord::Migration
  def change
    rename_column :wi_mn_dets, :dateStamp, :date
    rename_column :wi_mn_d_ave_t_airs, :dateStamp, :date
    rename_column :wi_mn_d_min_t_airs, :dateStamp, :date
    rename_column :wi_mn_d_max_t_airs, :dateStamp, :date
    rename_column :wi_mn_d_ave_vaprs, :dateStamp, :date
    
    rename_column :wi_mn_dets, :time, :time
    rename_column :wi_mn_d_ave_t_airs, :time, :time
    rename_column :wi_mn_d_min_t_airs, :time, :time
    rename_column :wi_mn_d_max_t_airs, :time, :time
    rename_column :wi_mn_d_ave_vaprs, :time, :time
  end
end
