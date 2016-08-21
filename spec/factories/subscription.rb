FactoryGirl.define do
  factory :subscription, class: Subscription do
    sequence(:topic_name) {|n| "topic#{n}" }
    sequence(:customer_id) {|n| "9" + "%03i" % "#{n}" }
    sequence(:account_no) {|n| "6" + "%09i" % "#{n}" }
    notify_by_sms "N"
    notify_by_email "Y"
    email_id "abc@foo.com"
    # created_by {Factory(:user).id}
    lock_version 0
    approval_status "A"
    last_action "C"
    is_enabled "Y"
  end
end
