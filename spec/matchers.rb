require 'rspec/expectations'

module TopicMatchers
  RSpec::Matchers.define :be_a_match_to_topic do |expected|
    match do |actual|
      expect(actual.version).to eq("1")
      expect(actual.topicsArray.topic.count).to eq(expected.count)
      expected.each do |topic|
        i = expected.find_index(topic)
        expect(actual.topicsArray.topic[i].topicName).to eq(topic.name)
        expect(actual.topicsArray.topic[i].topicDisplayName).to eq(topic.display_name)
        expect(actual.topicsArray.topic[i].topicGroup).to eq(topic.group_name)
        expect(actual.topicsArray.topic[i].needsSubscription).to eq(topic.convert_values(topic.needs_subscription))
        expect(actual.topicsArray.topic[i].notifyByEmail).to eq(topic.convert_values(topic.notify_by_email))
        expect(actual.topicsArray.topic[i].notifyBySMS).to eq(topic.convert_values(topic.notify_by_sms))
        expect(actual.topicsArray.topic[i].canBeBatched).to eq(topic.convert_values(topic.can_be_batched))
        expect(actual.topicsArray.topic[i].subscriptionProvider).to eq(topic.subscription_provider)
        criteria = actual.topicsArray.topic[i].criteriaDefinitionArray.criteriaDefinition
        topic_criterias = topic.topic_criterias
        expect(criteria.count).to eq(topic_criterias.count)
        topic_criterias.each do |c|
          j = topic_criterias.find_index(c)
          expect(criteria[j].name).to eq(c.name)
          expect(criteria[j].valueDataType).to eq(c.value_data_type)
          expect(criteria[j].condition).to eq(c.condition)
        end
      end
    end
  end

  RSpec::Matchers.define :be_a_match_to_subscription do |expected,customer_id|
    match do |actual|
      expected.each do |topic|
        i = expected.find_index(topic)
        subscription = Ns::Subscription.where("customer_id=? and is_enabled=? and topic_name=?",customer_id,'Y',topic.name).first rescue nil
        expect(actual.topicsArray.topic[i].subscription.subscribedAt.to_datetime).to eq(subscription.created_at)
        criteria = actual.topicsArray.topic[i].subscription.criteriaArray.criteria
        subscription_criterias = subscription.subscription_criterias
        expect(criteria.count).to eq(subscription_criterias.count)
        subscription_criterias.each do |c|
          j = subscription_criterias.find_index(c)
          expect(criteria[j].name).to eq(c.name)
          expect(criteria[j].value.decimalValue.to_s).to eq(c.decimal_value.to_s)
          expect(criteria[j].value.dateValue.to_s).to eq(c.date_value.to_s)
          expect(criteria[j].value.stringValue.to_s).to eq(c.string_value.to_s)
        end
      end
    end
  end
end
