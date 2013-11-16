class FlagsAndDoyRanges < ActiveRecord::Migration
  def self.up
    add_column :products, :subscribable, :boolean
    
    add_column :subscriptions, :doy_start, :integer
    add_column :subscriptions, :doy_end, :integer
    add_column :subscriptions, :enabled, :boolean, :default => true
    
    add_column :products, :default_doy_start, :integer
    add_column :products, :default_doy_end, :integer
  end

  def self.down
    remove_column :products, :subscribable, :boolean
    remove_column :products, :default_doy_end
    remove_column :products, :default_doy_start
    remove_column :subscriptions, :doy_end
    remove_column :subscriptions, :doy_start
    remove_column :subscriptions, :enabled
  end
end
