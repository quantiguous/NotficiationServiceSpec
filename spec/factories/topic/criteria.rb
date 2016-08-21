# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :topic_criteria, class: Topic::Criteria do
    ns_topic_id 1
    sequence(:name) {|n| "Criteria%01i" % "#{n}"}
    value_data_type "decimal" 
    condition "equals"
  end
end
