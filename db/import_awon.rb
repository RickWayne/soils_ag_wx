require 'net/http'
require 'json'
require 'date'
require 'time'
require 'fileutils'

# Import AWON records from a .dat file to the Rails application fronting the database.
# Do not overwrite existing records; figure out when the last import date was, and start
# with the day after that. This will not fill any holes before that last date!

# Uncomment one of these triplets.

# Run against WebRICK rails locally
# URL_PREFIX=''
# HOST = 'localhost'
# PORT = 3000

# Staging
# URL_PREFIX='/devel'
# HOST='agwx.soils.wisc.edu'
# PORT=80

# Production
URL_PREFIX='/uwex_agwx'
HOST='agwx.soils.wisc.edu'
PORT=80

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

# Given a datestamp in either YYYY-MM-DD HH:MM:SS or YYDOY format, return a Time or DateTime as appropriate
def to_timestamp(date_str)
  if date_str =~ /([\d]{2})([\d]{3})/
    year = $1.to_i
    if year > 79
      year += 1900
    else
      year += 2000
    end
    Date.new(year,1,1) + ($2.to_i - 1)
  else # must be YYYY-MM-DD or YYYY-MM-DD HH:MM:SS
    DateTime.parse(date_str)
  end
end

def line_datestamp(line,source)
  # For CR10, date is the third comma-separated field
  if source == CR10
    line =~ /^([\d]{3}),([\d]{4}),([^,]+),/
    date_str = $3
  else
    line =~ /^"([^"]+)",/
    date_str = $1
  end
  # puts "line_datestamp: date_str is #{date_str} from #{line.chomp}"
  begin
    line_date = to_timestamp(date_str)
  rescue Exception => e
    return nil
  end
  line_date
end
  
# Given a datestamp in either YYYY-MM-DD HH:MM:SS or YYDOY format and a datalogger line, return a strcmp-like date comparison
# -1: line is less than date_str or no date can be extracted, so keep going
#  0: line and date_str are same date
#  1: line's date > date_str
def datecmp(line,date_str,source=CR10,debug=true)
  date = to_timestamp(date_str)
  line_date = line_datestamp(line,source)
  # puts "datecmp: comparing datestamp #{date_str} (#{date.to_s}) to #{line[0..30]} (#{line_date.to_s})" if debug
  return -1 unless line_date
  return -1 if line_date < date
  return 0  if date == line_date
  return 1  if line_date > date
end
# seek the file to the first occurrence of >= the desired date (whether JD or Y-M-D).
# return the file and that line (since it has been consumed and we'll need it).
# if not found, line is nil.
def seek_to_date(infile,date_str,source,debug=nil)
  line = ''
  while (line=infile.gets) && (datecmp(line,date_str,source,debug) < 0)
    ;
  end
  [infile,line]
end

# Ping the Rails app to get all the AWON station database IDs. Return a Hash e.g. 4751 => 7
# (or whatever the ID of Hancock's record is in the database)
def awon_station_ids(http)
  stn_ids = {}
  JSON.parse(http.get("#{URL_PREFIX}/awon_stations.json").body).each do |rec|
    stn_ids[rec["stnid"]] = rec
  end
  stn_ids
end

def get_stnid(line,source=CR10)
  if source==CR10
    # 406,4751,12001,30,0,.022,.422,105.7,-.732,-.705,.449,3.96,1.668,1.586,86.5,17.97,0,2.68,.422
    return nil unless line && line =~ /^[\d]{3},([\d]{4}),/
    stnid_str=$1
  else
    # "TOA5","Han1000","CR1000","65951","CR1000.Std.27","CPU:TOWERS_4_16Sep.cr1","27255","DMet"
    return nil unless line && line =~ /,"(Han|Arl)1000","CR1000"/
    if $1 == "Arl"
      stnid_str = "4781"
    else
      stnid_str = "4751"
    end
  end
end

# Given YYYY-MM-DD HH:MM:SS and rectype, give the next one
def next_timedate_str(retdate,rectype)
  if retdate =~ /[\d]{5}/ # from 411, since legacy CR10 uploader needs that format for now
    date = to_timestamp(retdate)
    thisone = Time.parse("#{date} 00:00:00")
  else
    thisone = Time.parse(retdate)
  end
  case rectype
  when "401",401
    increment = 5 * 60 # five minutes
  when "406",406
    increment = 30 * 60
  when "411",411
    increment = 24 * 60 * 60 # one day
  when "412",412
    increment = 24 * 60 * 60
  end
  (thisone + increment).strftime("%Y-%m-%d %H:%M:%S")
end
# Ugh. Read the first line of the data file and detect what station ID we're using.
# Insertion code actually does this line-by-line, which is safer, but we have to grab
# the last-updated date for this station.

def get_next_jd_and_stnid(infile,http,source=CR10)
  line = infile.gets
  stnid_str=nil
  stnid_str = get_stnid(line,source)
  if source == CR10
    rec_type = "411"
  else
    4.times { line = infile.gets} # Skip other header lines
    fields = line.split(',')
    rec_type = extract_rec_type(fields,source)
  end
  infile.rewind
  raise "rec_type not found in #{line}" unless rec_type && rec_type != ''
  retdate = http.get("#{URL_PREFIX}/t#{rec_type}s/last.json?stnid=#{stnid_str}").body
  if source == CR10
    [next_jd_str(retdate),stnid_str]
  else
    [next_timedate_str(retdate,rec_type),stnid_str]
  end
end


# Given a record type (401,403,406,411, or 412), the attributes to set,
# and an open HTTP connection, POST a new record via the JSON endpoint (e.g. POST t401s.json)
def post(rectype,attribs,http)
  endpoint="#{URL_PREFIX}/t#{rectype}s.json"
  req = Net::HTTP::Post.new(endpoint,initheader = {'Content-Type' =>'application/json'})
  req.body = attribs.to_json
  http.request(req)
end

def extract_rec_type(fields,source)
  if source == CR10
    rec_type_index = 0
  elsif source == CR1000
    rec_type_index = 2
  else
    raise 'process_awon_upload: unknown source '+source
  end
  fields[rec_type_index].to_i
end

def make_integer_timestamp(six_digit_stamp)
  raise "invalid timestamp format #{six_digit_stamp}" unless six_digit_stamp =~ /^([\d]{2}):([\d]{2})/
  $1.to_i * 100 + $2.to_i
end

def adjust_date(date_str,rec_type)
  case rec_type
  # daily report carry date of when they were emitted (e.g. midnight, hence next day)
  # rather than the date of the weather that they report
  when "411", "412", 411, 412
    (Date.parse(date_str) - 1).to_s
  else
    date_str
  end
end

CR10=0
CR1000=1

def process_awon_upload(filename,source=CR10,debug=nil)
  puts "\nprocessing #{filename}" if debug
  begin
    infile = File.open(filename,'r')
    # Open the HTTP connection and keep it around
    http = Net::HTTP::new(HOST,PORT).start
    # Station info
    stnids = awon_station_ids(http)
    # Get the date of the last 411 for this station, calculate the next one as an AWON datestamp (yyjjj) or as a CR1000 time/date
    next_411_date,stnid_str = get_next_jd_and_stnid(infile,http,source)
    # if source == CR1000
    #       # It would be cleaner, I suppose, to just get the "real" date from the server. But this requires no
    #       # hacking upstream of this point, so we just convert the pseudo-Julian back to a real date, which is
    #       # what the CR1000 file contains.
    #       next_411_date =~ /([\d]{2})([\d]{3})/ # e.g. 16031 for January 1 2016
    #       next_411_date = dates_from_jd_str(next_411_date)[0].to_s # e.g. "2016-01-31"
    #       puts "next_411_date is #{next_411_date.inspect}" if debug
    #     end
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
    puts "field_descrips now has #{field_descrips.keys.size} kinds of records" if debug
    infile,line = seek_to_date(infile,next_411_date,source,debug)
    puts "after seek_to_date, line is now #{line}" if debug
    # line is now either nil or the first record of new data
    if source == CR10
      data_field_index = 4
    elsif source == CR1000
      data_field_index = 3
    else
      raise 'process_awon_upload: unknown source '+source
    end
    
    while line
      fields = line.split(',') # e.g. 401,4751,12001,255,.508,2.157,0
      print " line.." if debug
      rec = {}
      rec_type = extract_rec_type(fields,source)
      #FIXME: Is the AWON station ID even included in the file? Must be 'Han1000' in the first line for CR1000
      if source == CR10
        rec['awon_station_id'] = stnids[fields[1].to_i]["id"] # We want the foreign key, not 4751 or 4781
        rec['date'] = dates_from_jd_str(fields[2])[0]   # Convert e.g. '12001' into a date
        rec['time'] = time_from_date_and_timestamp(rec['date'],fields[3]) # Likewise, that plus '255' becomes a Time
      elsif source == CR1000
        rec['awon_station_id'] = stnids[stnid_str.to_i]["id"]
        fields[0] =~ /"([\d]{4}-[\d]{2}-[\d]{2}) ([\d]{2}:[\d]{2}:[\d]{2})"/
        # 411 and 412 are emitted at midnight, and so have the following day's date. Fix that.
        date_str = adjust_date($1,rec_type)
        rec['date'] = date_str
        rec['time'] = make_integer_timestamp($2)
      end

      begin
        (data_field_index..fields.size-1).each do |colnum|
          # e.g. rec['DMnBatt'] = 12.67
          descrip_index = (source == CR10 ? colnum : colnum + 1)
          rec[field_descrips[rec_type][descrip_index]['field_abbrev']] = fields[colnum].to_f
        end
        # Add the enclosing ActiveRecord model key
        params = {"t#{rec_type}" => rec}
        # Chuck it on up
        post(rec_type,params,http)
      rescue Exception => e
        puts "Error while importing: #{e.message} for '#{line.chomp}'"
        puts e.backtrace.inspect
        raise e
      end
      line=infile.gets
      print "."
    end
  ensure
    infile.close unless infile.nil? || infile == $stdin
    http.finish unless http.nil? || !(http.started?)
  end
  return next_411_date
end
