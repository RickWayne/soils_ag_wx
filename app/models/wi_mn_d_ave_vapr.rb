class WiMnDAveVapr < ActiveRecord::Base
  include Assessable
  def self.date_sym
    :dateStamp
  end
end
