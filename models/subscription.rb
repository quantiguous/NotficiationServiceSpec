class Subscription < ActiveRecord::Base
  self.table_name = "ns_subscriptions"
  has_many :subscription_criterias, :foreign_key => 'ns_subscription_id', :class_name => "Subscription::Criteria"
end
