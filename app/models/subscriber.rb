class Subscriber < ActiveRecord::Base
  has_many :subscriptions
  has_many :products, :through => :subscriptions
  # per http://stackoverflow.com/questions/201323/using-a-regular-expression-to-validate-an-email-address
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }
  
  
  def self.fractional_part(float)
    float.to_s =~ /0\.(.+)$/
    $1
  end
  
  def self.confirmation_number
    fractional_part(rand)
  end
  
  def send_subscriptions(start_date=Date.today-1,finish_date=Date.today-1)
  end
  
  def has_confirmed
    begin
      DateTime.parse confirmed
      true
    rescue Exception => e
      false
    end
  end
end
