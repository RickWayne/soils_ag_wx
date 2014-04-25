class RenameDailyEtTableInProducts < ActiveRecord::Migration
  def change
    Product.where(data_table_name: 'WiMnDET').each { |product| product.data_table_name = 'wi_mn_dets'; product.save! }
  end
end
