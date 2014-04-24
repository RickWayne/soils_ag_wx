class WiMnDAveVapr < ActiveRecord::Base
  include Assessable
  def self.date_sym
    :date
  end
end
