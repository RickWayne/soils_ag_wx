require File.join(File.dirname(__FILE__),'..','config','environment.rb')


# Glom a date from params. If a string, parse it. If not provided or parse fails, 1 day ago. 
def extract_date(params,sym)
  if (d=params[sym])
    if d.kind_of?(String)
      begin
        Date.parse(d)
      rescue Exception => e
        Date.today - 1
      end
    else
      d
    end
  else
    Date.today - 1
  end
end

def send_emails(params)
  if params[:id] == 0
    puts "sending to everyone"
    subscribers = Subscriber.where("email like ?",'fewayne%')
  else
    subscribers = [Subscriber.find(params[:id])]
  end
  subscribers = subscribers.select { |subs| subs.has_confirmed }
  start_date = extract_date(params,:start_date)  
  end_date = extract_date(params,:end_date)
  sent = 0
  results = []
  subscribers.each do |subs|
    email = SubscriptionMailer.product_report(subs,start_date,end_date)
    unless email.body.encoded
      puts "No body"
      next
    end
    unless email.body.encoded != ""
      puts "Body blank"
      next
    end
    unless email.body.encoded =~ /At/
      puts "No 'At'"
      next
    end
    unless email.body.encoded =~ /0\.[\d]/
      puts "No ET value"
      next
    end
    results << email.deliver
    sent += 1
  end
  puts "Sent #{sent} emails"
end

rick = Subscriber.find_by_email('fewayne@wisc.edu')
if ARGV[0]
  if ARGV[0] == 'everybody'
    id = 0
  else
    id =ARGV[0].to_i
  end
else
  puts "usage: send_emails.rb {everybody|id} [start_date] [end_date] (a test id for rick is #{rick[:id]})"
  exit
end

if ARGV[1]
  start_date = Date.parse(ARGV[1])
else
  start_date = nil
end

if ARGV[2]
  end_date = Date.parse(ARGV[2])
else
  end_date = nil
end

send_emails({id: id, start_date: start_date, end_date: end_date})