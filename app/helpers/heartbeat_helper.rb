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
    color = value ? "green" : "red"
    "<span style='color:#{color}'>#{key}</span>"
  end
end
