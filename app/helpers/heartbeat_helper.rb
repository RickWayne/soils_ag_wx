module HeartbeatHelper
  def result_table(title,results)
    ret = "<h4>#{title}:</h4><table border='1'><tr>"
    results.each do |str,result|
      ret += "<td>#{result_span(str,result)}</td>"
    end
    ret += "</tr></table>"
    ret.html_safe
  end
  
  def result_span(key,value)
    if value
      "<span style='padding:1px;color:white;background-color:green'>#{key}</span>"
    else
      "<span style='padding:1px;color:black;background-color:#F0A0A0'>#{key}</span>"    
    end
  end
end
