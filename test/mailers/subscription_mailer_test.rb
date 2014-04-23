require 'test_helper'

class SubscriptionMailerTest < ActionMailer::TestCase
  RICKS_EMAIL = 'fewayne@gmail.com'
  SENDER_EMAIL = 'fewayne@wisc.edu'
  
  def setup
    @rick = Subscriber.create! name: 'Rick Wayne', email: RICKS_EMAIL, confirmed: Subscriber.confirmation_number
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
    mail = SubscriptionMailer.product_report
    assert_equal "Product report", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
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
