require 'test_helper'

class SubscriptionMailerTest < ActionMailer::TestCase
  RICKS_EMAIL = 'fewayne@gmail.com'
  SENDER_EMAIL = 'fewayne@wisc.edu'
  RICK = 'Rick Me Bucko'
  LATITUDE = 42.0
  LONGITUDE = -89.0
  ETS = [0.05,0.10,0.15,0.20,0.25,0.30,0.35]
  
  def setup
    @etgrid = Product.create! name: 'ET', data_table_name: 'wi_mn_dets', type: 'GridProduct', subscribable: true 
    @rick = Subscriber.create! name: RICK, email: RICKS_EMAIL, confirmed: Subscriber.confirmation_number
    @rick_subs = Subscription.create! latitude: LATITUDE, longitude: LONGITUDE,
      product_id: GridProduct.first[:id], doy_start: 1, doy_end: 365
    ETS.each_with_index { |et,ii| WiMnDet.create! date: days_back(ii), latitude: LATITUDE, w892: et }
    @rick.subscriptions << @rick_subs; @rick.save!
  end
  
  def days_back(ii)
    Date.today - (ii+1)
  end
  
  test "confirm" do
    mail = SubscriptionMailer.confirm(@rick)
    assert_equal 'Please confirm your email address for your UWEX Ag Weather product subscriptions', mail.subject
    assert_equal [RICKS_EMAIL], mail.to
    assert_equal [RICKS_EMAIL], mail.to
    assert_equal [SENDER_EMAIL], mail.from
    assert_match "Hi Rick Wayne,\r\n\r\n", mail.body.encoded
  end

  test "product_report" do
    mail = SubscriptionMailer.product_report(@rick,Date.today - 7, Date.today - 1)
    assert_equal "Product report", mail.subject
    assert_equal [RICKS_EMAIL], mail.to
    assert_equal [SENDER_EMAIL], mail.from
    results = mail.body.encoded
    assert(results =~ Regexp.new(RICK))
    ETS.each_with_index do |et,ii|
      date = days_back(ii).to_s
      assert(results =~ /#{date},#{et}/,"Could not find a line with #{date} and #{et}\n#{WiMnDet.all.collect {|et| et.date }.inspect}")
    end
    
  end

  test "special" do
    mail = SubscriptionMailer.special(@rick,'')
    assert_equal "Special", mail.subject
    assert_equal [RICKS_EMAIL], mail.to
    assert_equal [SENDER_EMAIL], mail.from
    assert_match "Hi Rick Wayne,\r\n\r\n", mail.body.encoded
  end

end
