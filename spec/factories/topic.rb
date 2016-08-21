
FactoryGirl.define do
  factory :ns_topic, class: Topic  do
    sequence(:name) {|n| "testtopic#{n}" }
    is_enabled 'Y'
    needs_subscription 'Y'
    notify_by_email 'N'
    notify_by_sms 'Y'
    display_name "Topic1"
    group_name "Group1"
    subscription_provider "Foo"
    sms_text "Test"
    email_sub "Test"
    email_body "Testing Foo"
    # created_by {Factory(:user).id}
    expire_after 5
    lock_version 0
    approval_status 'A'
    last_action 'C'
  end
end
