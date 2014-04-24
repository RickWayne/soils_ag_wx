require 'test_helper'

class SubscriptionMailerTest < ActionMailer::TestCase
  RICKS_EMAIL = 'fewayne@gmail.com'
  SENDER_EMAIL = 'fewayne@wisc.edu'
  
  def setup
    @etgrid = Product.create! name: 'ET', data_table_name: 'wi_mn_dets', type: 'GridProduct', subscribable: true 
    @rick = Subscriber.create! name: 'Rick Wayne', email: RICKS_EMAIL, confirmed: Subscriber.confirmation_number
    @rick_subs = Subscription.create! subscriber_id: @rick[:id], latitude: 42.0, longitude: -89.0,
      product_id: GridProduct.first[:id], doy_start: 1, doy_end: 365
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
    mail = SubscriptionMailer.product_report(@rick,Date.today - 5, Date.today)
    assert_equal "Product report", mail.subject
    assert_equal [RICKS_EMAIL], mail.to
    assert_equal [SENDER_EMAIL], mail.from
    assert_match "Hi", mail.body.encoded
  end

  test "special" do
    mail = SubscriptionMailer.special(@rick,'')
    assert_equal "Special", mail.subject
    assert_equal [RICKS_EMAIL], mail.to
    assert_equal [SENDER_EMAIL], mail.from
    assert_match "Hi Rick Wayne,\r\n\r\n", mail.body.encoded
  end

end
