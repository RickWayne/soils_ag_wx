require 'net/http'
require 'json'
require 'date'

# Import AWON records from a .dat file to the Rails application fronting the database.
# Do not overwrite existing records; figure out when the last import date was, and start
# with the day after that. This will not fill any holes before that last date!

# Uncomment one of these triplets.

# Run against WebRICK rails locally
# URL_PREFIX=''
# HOST = 'localhost'
# PORT = 3000

# Staging
URL_PREFIX='/devel'
HOST='agwx.soils.wisc.edu'
PORT=80

# Production
# URL_PREFIX='/uwex_agwx'
# HOST='agwx.soils.wisc.edu'
# PORT=80


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
# E.g. '10300' yields '10301', '11365' yields '12001', '12365' yields '12366'
def next_jd_str(prev_jd_str)
  nextdate = dates_from_jd_str(prev_jd_str)[1]
  nextdate.strftime('%y%j')
end

# From an AWON timestamp ('30', '130', '2130') and a date, return a Time for that date, hour, and minute
def time_from_date_and_timestamp(date,timestamp_str)
  return nil unless timestamp_str =~ /([\d]{0,2})([\d]{2})/
  hour = $1 == "" ? 0 : $1.to_i
  min = $2.to_i
  Time.local(date.year,date.month,date.day,hour,min)
end

# seek the file to the first occurence of the desired JD date.
# return the file and that line (since it has been consumed and we'll need it).
# if not found, line is nil.
def seek_to_date(infile,jd_str)
  line = ''
  while (line=infile.gets) && (!line.index(jd_str))
    ;
  end
  [infile,line]
end

# Ping the Rails app to get all the AWON station database IDs. Return a Hash e.g. 4751 => 7
# (or whatever the ID of Hancock's record is in the database)
def awon_station_ids(http)
  stn_ids = {}
  JSON.parse(http.get("#{URL_PREFIX}/awon_stations.json").body).each do |rec|
    stn_ids[rec["stnid"]] = rec["id"]
  end
  stn_ids
end

# Given a record type (401,403,406,411, or 412), the attributes to set,
# and an open HTTP connection, POST a new record via the JSON endpoint (e.g. POST t401s.json)
def post(rectype,attribs,http)
  endpoint="#{URL_PREFIX}/t#{rectype}s.json"
  req = Net::HTTP::Post.new(endpoint,initheader = {'Content-Type' =>'application/json'})
  req.body = attribs.to_json
  http.request(req)
end

begin
  # usage: either import_awon <filename> or as a filter, import_awon.rb < filename
  if ARGV[0]
    infile = File.open(ARGV[0],'r')
  else
    infile = $stdin
  end
  # Open the HTTP connection and keep it around
  http = Net::HTTP::new(HOST,PORT).start
  # Get the date of the last 411, calculate the next one as an AWON datestamp (yyjjj)
  next_411_jd = next_jd_str(http.get("#{URL_PREFIX}/t411s/last.json").body)
  field_descrips = {}
  # Glom all the field_descrip recs out of the database. Make a hash of hashes, top level is rec id,
  # then by column number, values are the field descrip record hashes (including redundant info), e.g.
  # {401 => {4 => {
  #                 "rec_id"=>401, "column_num"=>4, "field_name"=>"Five-Minute Precipitation",
  #                 "field_abbrev"=>"M5Pcpn", "units"=>"mm", "decimals"=>3,
  #                 "url"=>"http://localhost:3000/awon_field_descrips/108.json"
  #               }
  #         }
  # }
  JSON.parse(http.get("#{URL_PREFIX}/awon_field_descrips.json").body).each do |rec|
    field_descrips[rec["rec_id"]] ||= {}
    field_descrips[rec["rec_id"]][rec["column_num"]] = rec
  end
  stnids = awon_station_ids(http)
  infile,line = seek_to_date(infile,next_411_jd)
  # line is now either nil or the first record of new data
  while line
    fields = line.split(',') # e.g. 401,4751,12001,255,.508,2.157,0
    rec = {}
    rec_type = fields[0].to_i
    rec['awon_station_id'] = stnids[fields[1].to_i] # We want the foreign key, not 4751 or 4781
    rec['date'] = dates_from_jd_str(fields[2])[0]   # Convert e.g. '12001' into a date
    rec['time'] = time_from_date_and_timestamp(rec['date'],fields[3]) # Likewise, that plus '255' becomes a Time
    (4..fields.size-1).each do |colnum|
      # e.g. rec['DMnBatt'] = 12.67
      rec[field_descrips[rec_type][colnum]['field_abbrev']] = fields[colnum].to_f
    end
    # Add the enclosing ActiveRecord model key
    params = {"t#{rec_type}" => rec}
    # Chuck it on up
    post(rec_type,params,http)
    line=infile.gets
  end
ensure
  infile.close unless infile.nil? || infile == $stdin
  http.finish unless http.nil? || !(http.started?)
end
