require 'test_helper'

YESTERDAY = 1.day.ago
TODAY = YESTERDAY + 1.day
PRESENT = ['thing = ?',40]
NOT_PRESENT = ['something = ?',50]

# An ActiveRecord mock which responds to "where" but never returns a result
class AlwaysEmpty
  def self.where(condition)
    return self
  end
  def self.size
    0
  end
end

class ATester
  include Assessable
  
  def self.date_sym
    :fnord
  end
  
  # Return the results of a "database query" which will be specified as {fnord: some_date}
  def self.where(condition)
    if condition.class == Hash
      # Date condition
      if condition[:fnord] == YESTERDAY
        return self # ready for another chained "where"
      else
        return AlwaysEmpty
      end
    elsif condition.class == Array
      if condition == PRESENT
        return [self] # Anything will do, so long as it responds to "size" and size == 1
      else
        return AlwaysEmpty
      end
    else
      return AlwaysEmpty
    end
  end
end

class AssessableTest < ActiveSupport::TestCase
  def setup
    @a_tester = ATester.new
  end

  test "can instantiate" do
    assert @a_tester
  end
  
  def test_yesterday_for_nil_returns_1_day_ago
    assert_equal(1.day.ago.to_i, ATester.yesterday_for.to_i, "#{1.day.ago.inspect} / #{ATester.yesterday_for}")
  end
  
  def test_yesterday_for_Time
    now = Time.now
    assert_equal((now - 24 * 3600).to_i, ATester.yesterday_for(now).to_i)
  end
  
  def test_yesterday_for_Date
    today = Date.today
    yesterday = today - 1
    assert_equal(Date, yesterday.class)
    yf = ATester.yesterday_for(today)
    assert_equal(yesterday, yf)
  end

  def test_yesterday_for_DateTime
    today = DateTime.now
    yesterday = today - 1.day
    yf = ATester.yesterday_for(today)
    assert_equal(yesterday,yf)
  end
  
  def test_where
    res = ATester.where(fnord: YESTERDAY).where(PRESENT)
    assert_equal(Array, res.class)
    assert_equal(1, res.size)
    res = ATester.where(PRESENT)
    assert_equal(Array, res.class)
    assert_equal(1, res.size)
    # mismatched 'date' sym
    res = ATester.where(thing: YESTERDAY).where(PRESENT)
    assert_equal(AlwaysEmpty,res)
    # wrong date
    res = ATester.where(fnord: Date.today).where(PRESENT)
    assert_equal(AlwaysEmpty,res)
    # right date, conditions wrong
    res = ATester.where(fnord: Date.today).where(NOT_PRESENT)
    assert_equal(AlwaysEmpty,res)
  end
  
  def test_has_yesterday
    assert_equal(true, ATester.hasYesterday(PRESENT,TODAY))
    assert_equal(false, ATester.hasYesterday(PRESENT,2.days.ago))
    assert_equal(false, ATester.hasYesterday(NOT_PRESENT,YESTERDAY))
    assert_equal(false, ATester.hasYesterday(NOT_PRESENT,2.days.ago))
  end
  
end
