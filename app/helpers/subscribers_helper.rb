module SubscribersHelper
  def title
    "Automated Weather Product Subscriptions"
  end
  def do_welcome
    str = <<-END
    #{image_tag "awon.jpg",{:width => "231", :height => "347", :alt => "weather station"}}
    <h2>#{link_to "#{title}", :action => "index"}</h2>
    END
    str
  end
end
