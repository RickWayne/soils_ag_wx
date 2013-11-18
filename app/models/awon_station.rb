class AwonStation < ActiveRecord::Base
  has_many :t401s
  has_many :t403s
  has_many :t406s
  has_many :t411s
  has_many :t412s
end
