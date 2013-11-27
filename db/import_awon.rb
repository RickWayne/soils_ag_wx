require 'net/http'
require 'json'
require 'date'

# URL_PREFIX = '/devel'
URL_PREFIX=''
HOST = 'localhost'
PORT = 3000

# return the Date the str refers to, plus the next day
def dates_from_jd_str(jd_str)
  nil unless jd_str =~ /([\d]{2})([\d]{3})/
  yr = $1.to_i
  doy = $2.to_i
  # Hack, I know, but all AWON data is after 1985
  yr = (yr < 80 ? 2000 + yr : 1900 + yr)
  # Note that since Jan 1 is DOY 1 and not 0, this give us the next day in the calendar from the
  # one passed in.
  date = Date.civil(yr,1,1) + doy
  [date - 1, date]
end

# Get the two-digit year + DOY timestamp for the day after the one passed in.
def next_jd_str(prev_jd_str)
  nextdate = dates_from_jd_str(prev_jd_str)[1]
  nextdate.strftime('%y%j')
end

def time_from_date_and_timestamp(date,timestamp_str)
  return nil unless timestamp_str =~ /([\d]{0,2})([\d]{2})/
  hour = $1 == "" ? 0 : $1.to_i
  min = $2.to_i
  Time.local(date.year,date.month,date.day,hour,min)
end

# seek the file to the first occurence of the desired JD date.
# return the file and that line (since it has been consumed and we'll need it).
def seek_to_date(infile,jd_str)
  line = ''
  while (line=infile.gets) && (!line.index(jd_str))
    ;
  end
  [infile,line]
end

def awon_station_ids
  stn_ids = {}
  JSON.parse(Net::HTTP.get(HOST,"#{URL_PREFIX}/awon_stations.json")).each do |rec|
    stn_ids[rec["stnid"]] = rec["id"]
  end
  stn_ids
end

def connection(rectype)
  endpoint="#{URL_PREFIX}/t#{rectype}s.json"
  req = Net::HTTP::Post.new(endpoint,initheader = {'Content-Type' =>'application/json'})
  Net::HTTP::new(HOST,PORT).start
end

def post(rectype,attribs)
  endpoint="#{URL_PREFIX}/t#{rectype}s.json"
  req = Net::HTTP::Post.new(endpoint,initheader = {'Content-Type' =>'application/json'})
  req.body = attribs.to_json
  Net::HTTP::new(HOST,PORT).start {|http| http.request(req)}
end

begin
  if ARGV[0]
    infile = File.open(ARGV[0],'r')
  else
    infile = $stdin
  end
  next_411_jd = next_jd_str(Net::HTTP.get(HOST,"#{URL_PREFIX}/t411s/last.json"))
  field_descrips = {}
  JSON.parse(Net::HTTP.get(HOST,"#{URL_PREFIX}/awon_field_descrips.json")).each do |rec|
    field_descrips[rec["rec_id"]] ||= {}
    field_descrips[rec["rec_id"]][rec["column_num"]] = rec
  end
  stnids = awon_station_ids
  infile,line = seek_to_date(infile,next_411_jd)
  begin
    fields = line.split(',') # e.g. 401,4751,12001,255,.508,2.157,0
    rec = {}
    rec_type = fields[0].to_i
    rec['awon_station_id'] = stnids[fields[1].to_i]
    rec['date'] = dates_from_jd_str(fields[2])[0]
    rec['time'] = time_from_date_and_timestamp(rec['date'],fields[3])
    (4..fields.size-1).each do |colnum|
      rec[field_descrips[rec_type][colnum]['field_abbrev']] = fields[colnum].to_f
    end
    params = {"t#{rec_type}" => rec}
    post(rec_type,params)
    exit
  end while (line=infile.gets)
ensure
  infile.close unless infile.nil? || infile == $stdin  
end
