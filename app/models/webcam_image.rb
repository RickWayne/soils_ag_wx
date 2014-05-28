WEBCAM_THUMB = 1
WEBCAM_FULL = 2
class WebcamImage < ActiveRecord::Base
  DFORMAT = "%Y_%m_%d_%H_%M_%S"

  def self.half_filename(timestamp)
    timestamp.strftime("halfsize_#{DFORMAT}.jpg")
  end

  def self.full_filename(timestamp)
    timestamp.strftime("fullsize_#{DFORMAT}.jpg")
  end
  
end
