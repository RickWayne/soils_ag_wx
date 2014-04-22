class Subscription < ActiveRecord::Base
  belongs_to :subscriber
  belongs_to :product
  
  def within_doy_range(range_start_doy, range_end_doy=range_start_doy)
    return true unless doy_start && doy_end
    return true unless doy_start < doy_end
    return doy_start <= range_start_doy && range_end_doy <= doy_end
  end
  #
  # Create a report for a set of subscriptions. Usually this will be for a single user, but that's
  # not built in. A report is a hash keyed by product; each product maps to an array of point subscriptions,
  # which are in turn hashes keyed by the subscription; each subscription (lat/long point) maps to an array
  # of date-string => value hashes. So the whole thing looks like:
  #
  # {
  #   Product 1 => [
  #     Subscription 1 => [
  #       { date_string1 => value}
  #       { date_string2 => value}
  #       etc.
  #     ]
  #     Subscription 2 => [
  #       { date_string1 => value} # This will be the same date as above. DRYing that looks too painful!
  #       { date_string2 => value}
  #       etc.
  #     ]
  #   ]
  #   Product 2 => [
  #     Subscription 3 => [
  #       { date_string1 => value}
  #       { date_string2 => value}
  #       etc.
  #     ]
  #     Subscription 4 => [
  #       { date_string1 => value}
  #       { date_string2 => value}
  #       etc.
  #     ]
  #   ]
  # }
  def self.make_report(subscriptions,start_date,finish_date)
    report = {}
    # force the "list" of subscriptions passed in to be one, even if it was a single Subscription
    subscriptions = [subscriptions] if subscriptions.kind_of?(Subscription)
    sorted = subscriptions.group_by {|subs| subs.product}
    sorted.each do |product,subscriptions|
      report[product] = []
      subscriptions.each do |subscr|
        next unless subscr.enabled # Skip anything with "enabled" set to false; default to "true" in database
        next unless subscr.within_doy_range(start_date.yday,finish_date.yday) # Returns true if no doy range set
        data = subscr.product.series_with_dates(subscr.latitude,subscr.longitude,start_date,finish_date)
        next unless data && data.size > 0
        report[product] << {subscr => data}
      end
    end
    report
  end
end
