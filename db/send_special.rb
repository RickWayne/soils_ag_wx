require File.join(File.dirname(__FILE__),'..','config','environment.rb')

def send_emails(params)
  if params[:id] == 0
    puts "sending to everyone"
    subscribers = Subscriber.all
  else
    subscribers = [Subscriber.find(params[:id])]
  end
  unless params[:message_text] && (message_text = params[:message_text]) != ''
    puts "usage: send_special.rb {everybody|id} message_file"
    exit
  end
  subscribers = subscribers.select { |subs| subs.has_confirmed }
  sent = 0
  results = []
  subscribers.each do |subs|
    email = SubscriptionMailer.special(subs,message_text)
    unless email.body.encoded
      puts "No body"
      next
    end
    unless email.body.encoded != ""
      puts "Body blank"
      next
    end
    unless email.body.encoded =~ /Hi/
      puts "No 'Hi' in '#{email.body.encoded}'"
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
  puts "usage: send_special.rb {everybody|id} message_file"
  exit
end

if ARGV[1]
  message_text = File.open(ARGV[1]).read
else
  puts "usage: send_special.rb {everybody|id} message_file"
  exit
end

send_emails({id: id, message_text: message_text})