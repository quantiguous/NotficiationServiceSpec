require_relative '../subscription'
class Subscription::Criteria < ActiveRecord::Base
  self.table_name = "ns_subscription_criteria"
end
