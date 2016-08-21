FactoryGirl.define do
  factory :ns_app, class: App  do
    sequence(:appid) {|n| "ABC%04i" % "#{n}"}
    is_enabled 'Y'
    # created_by {Factory(:user).id}
    lock_version 0
    approval_status 'A'
    last_action 'C'
  end
end
