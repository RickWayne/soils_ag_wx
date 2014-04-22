require 'test_helper'

class SubscriptionMailerTest < ActionMailer::TestCase
  test "confirm" do
    mail = SubscriptionMailer.confirm
    assert_equal "Confirm", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

  test "product_report" do
    mail = SubscriptionMailer.product_report
    assert_equal "Product report", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

  test "special" do
    mail = SubscriptionMailer.special
    assert_equal "Special", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
