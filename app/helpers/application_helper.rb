module ApplicationHelper
  def borked
    str = <<-END
      <h3>Page under reconstruction</h3>
      <p>Due to a major overhaul of Soil Science's Web infrastucture, some of our products are broken right now. Unfortunately, you've found one. We are working hard on it and hope to have them all back up in a couple of days. We apologize for the inconvenience. (2013-11-19)</p>
    END
    str.html_safe
  end
end
