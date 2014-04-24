json.array!(@wi_mn_d_ave_vaprs) do |wi_mn_d_ave_vapr|
  json.extract! wi_mn_d_ave_vapr, :date, :time, :latitude, :w980, :w976, :w972, :w968, :w964, :w960, :w956, :w952, :w948, :w944, :w940, :w936, :w932, :w928, :w924, :w920, :w916, :w912, :w908, :w904, :w900, :w896, :w892, :w888, :w884, :w880, :w876, :w872, :w868, :w864, :w860
  json.url wi_mn_d_ave_vapr_url(wi_mn_d_ave_vapr, format: :json)
end
