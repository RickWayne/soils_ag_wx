require File.join(File.dirname(__FILE__),'..','config','environment.rb')

def send_emails(params)
  if params[:id] == '0'
    raise "not ready to send to everyone yet!"
    subscribers = Subscriber.all
  else
    subscribers = [Subscriber.find(params[:id])]
  end
  puts "all selected subscribers " +subscribers.inspect
  subscribers = subscribers.select { |subs| subs.has_confirmed }
  puts "confirmed subscribers now "+subscribers.inspect
  start_date = finish_date = 1.day.ago
  begin
    start_date = Date.parse(params[:start_date]) if params[:start_date]
    finish_date = Date.parse(params[:finish_date]) if params[:finish_date]
  rescue Exception => e
    start_date = 1.day.ago unless start_date
    finish_date = 1.day.ago unless finish_date
  end
  
  sent = 0
  results = []
  subscribers.each do |subs|
    email = SubscriptionMailer.product_report(subs,start_date,finish_date)
    puts email.body.encoded
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
    puts "Sent:\n" + email.body.encoded
    results << email.deliver
    sent += 1
  end
  results.each { |res| puts res.inspect }
  puts "Sent #{sent} emails"
end

rick = Subscriber.find_by_email('fewayne@wisc.edu')
send_emails({id: rick[:id]})
