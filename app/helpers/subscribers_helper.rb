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
  
  def product_select_options(products)
    prod_map = products.reject { |p| p.name =~ /Cranberry/ }.map { |p| [p[:name],p[:id]] }
    options_for_select prod_map << ['Please select a product', -1 ], disabled: -1, selected: -1
  end
  
end
