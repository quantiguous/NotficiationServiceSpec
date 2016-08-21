require 'rspec/expectations'

module TopicMatchers
  RSpec::Matchers.define :be_a_match_to_topic do |expected|
    match do |actual|
      actual.version.should be == "1"
      actual.topicsArray.topic.count.should be == expected.count
      expected.each do |topic|
        i = expected.find_index(topic)
        actual.topicsArray.topic[i].topicName.should be == topic.name
        actual.topicsArray.topic[i].topicDisplayName.should be == topic.display_name
        actual.topicsArray.topic[i].topicGroup.should be == topic.group_name
        actual.topicsArray.topic[i].needsSubscription.should be == topic.convert_values(topic.needs_subscription)
        actual.topicsArray.topic[i].notifyByEmail.should be == topic.convert_values(topic.notify_by_email)
        actual.topicsArray.topic[i].notifyBySMS.should be == topic.convert_values(topic.notify_by_sms)
        actual.topicsArray.topic[i].canBeBatched.should be == topic.convert_values(topic.can_be_batched)
        actual.topicsArray.topic[i].subscriptionProvider.should be == topic.subscription_provider
        criteria = actual.topicsArray.topic[i].criteriaDefinitionArray.criteriaDefinition
        topic_criterias = topic.topic_criterias
        criteria.count.should be == topic_criterias.count
        topic_criterias.each do |c|
          j = topic_criterias.find_index(c)
          criteria[j].name.should be == c.name
          criteria[j].valueDataType.should be == c.value_data_type
          criteria[j].condition.should be == c.condition
        end
      end
    end
  end

  RSpec::Matchers.define :be_a_match_to_subscription do |expected,customer_id|
    match do |actual|
      expected.each do |topic|
        i = expected.find_index(topic)
        subscription = Ns::Subscription.where("customer_id=? and is_enabled=? and topic_name=?",customer_id,'Y',topic.name).first rescue nil
        actual.topicsArray.topic[i].subscription.subscribedAt.to_datetime.should be == subscription.created_at
        criteria = actual.topicsArray.topic[i].subscription.criteriaArray.criteria
        subscription_criterias = subscription.subscription_criterias
        criteria.count.should be == subscription_criterias.count
        subscription_criterias.each do |c|
          j = subscription_criterias.find_index(c)
          criteria[j].name.should be == c.name
          criteria[j].value.decimalValue.to_s.should be == c.decimal_value.to_s
          criteria[j].value.dateValue.to_s.should be == c.date_value.to_s
          criteria[j].value.stringValue.to_s.should be == c.string_value.to_s
        end
      end
    end
  end
end
