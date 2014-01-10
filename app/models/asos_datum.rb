class AsosDatum < ActiveRecord::Base
  belongs_to :asos_station
  include Assessable
end
