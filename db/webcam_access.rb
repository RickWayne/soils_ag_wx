require 'net/http'

CAM_ADDR='128.104.33.220'

def geddit(http,url_path,save_path,save_fname)
  req = Net::HTTP::Get.new(url_path)
  req.basic_auth 'cam','get-me-a-picture'
  res = http.request(req)
  case res
  when Net::HTTPSuccess
    File.open("#{save_path}/#{save_fname}","wb") { |f| f.puts(res.body) }
    return true
  else
    return false
  end
end

