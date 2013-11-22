class Product < ActiveRecord::Base
  has_many :subscriptions
  
  def description
    name
  end
end
