# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :subscription_criteria, class: Subscription::Criteria do
    ns_subscription_id 1
    sequence(:name) {|n| "Criteria %01i" % "#{n}"}
    value_data_type "decimal" 
    condition "equals"
  end
end
