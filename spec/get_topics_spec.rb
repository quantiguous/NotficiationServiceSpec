require 'api_banking'
require_relative 'support/models'
require_relative 'support/factory_girl'
require_relative 'matchers'

RSpec.describe "notification_service" do
  include TopicMatchers

  before(:all) do
    ApiBanking::NotificationService.configure do |config|
      config.environment = ApiBanking::Environment::QG::DEMO.new(ENV['API_USERNAME'], ENV['API_PASSWORD'])
    end
    @app1 = FactoryGirl.create(:ns_app) 
    @topic1 = FactoryGirl.create(:ns_topic, :group_name => 'Group1')      
    @topic2 = FactoryGirl.create(:ns_topic, :group_name => 'Group1')
    @topic3 = FactoryGirl.create(:ns_topic, :group_name => 'Group1')      
    @topic4 = FactoryGirl.create(:ns_topic, :group_name => 'Group1')
    @topic5 = FactoryGirl.create(:ns_topic, :group_name => 'Group2')      
    @topic6 = FactoryGirl.create(:ns_topic, :group_name => 'Group2')
    @topic_criteria1 = FactoryGirl.create(:topic_criteria, :ns_topic_id => @topic1.id)
    @topic_criteria2 = FactoryGirl.create(:topic_criteria, :ns_topic_id => @topic2.id)
    @topic_criteria3 = FactoryGirl.create(:topic_criteria, :ns_topic_id => @topic3.id)
    @topic_criteria4 = FactoryGirl.create(:topic_criteria, :ns_topic_id => @topic4.id)
    @topic_criteria5 = FactoryGirl.create(:topic_criteria, :ns_topic_id => @topic5.id)
    @topic_criteria6 = FactoryGirl.create(:topic_criteria, :ns_topic_id => @topic6.id)
    @subscription1 = FactoryGirl.create(:subscription, :topic_name => @topic1.name, :customer_id => '1234')
    @subscription2 = FactoryGirl.create(:subscription, :topic_name => @topic2.name, :customer_id => '1234')
    @subscription3 = FactoryGirl.create(:subscription, :topic_name => @topic5.name, :customer_id => '1234')
    @subscription_criteria1 = FactoryGirl.create(:subscription_criteria, :ns_subscription_id => @subscription1.id, :name => @topic_criteria1.name, :value_data_type => @topic_criteria1.value_data_type, :condition => @topic_criteria1.condition, :decimal_value => 12.3)
    @subscription_criteria2 = FactoryGirl.create(:subscription_criteria, :ns_subscription_id => @subscription2.id, :name => @topic_criteria2.name, :value_data_type => @topic_criteria2.value_data_type, :condition => @topic_criteria2.condition, :decimal_value => 13.5)
    @subscription_criteria3 = FactoryGirl.create(:subscription_criteria, :ns_subscription_id => @subscription3.id, :name => @topic_criteria5.name, :value_data_type => @topic_criteria5.value_data_type, :condition => @topic_criteria5.condition, :decimal_value => 100.5)
  end

  after(:all) do
    @topic1.delete
    @topic2.delete
    @topic3.delete
    @topic4.delete
    @topic5.delete
    @topic6.delete
    @topic_criteria1.delete
    @topic_criteria2.delete
    @topic_criteria3.delete
    @topic_criteria4.delete
    @topic_criteria5.delete
    @topic_criteria6.delete
    @app1.delete
    @subscription1.delete
    @subscription2.delete
    @subscription3.delete
    @subscription_criteria1.delete
    @subscription_criteria2.delete
    @subscription_criteria3.delete
  end

  context "get topics" do 
    it "should return all topics for the group specified in the request" do 
      criteria = ApiBanking::NotificationService::GetTopics::ReqCriteria.new()
      request = ApiBanking::NotificationService::GetTopics::Request.new()
      criteria.topicGroup = @topic1.group_name
      request.appID = @app1.appid
      request.criteria = criteria
      p request
      result = ApiBanking::NotificationService.getTopics(request)
      p result
      result.should be_a_match_to_topic([@topic1,@topic2,@topic3,@topic4])
    end

    it "should return all subscribed topics for the group & customer specified in the request" do 
      criteria = ApiBanking::NotificationService::GetTopics::ReqCriteria.new()
      request = ApiBanking::NotificationService::GetTopics::Request.new()
      subscriber = ApiBanking::NotificationService::GetTopics::Subscriber.new()
      subscriber.customerID = '1234'
      subscriber.subscribed = 'true'
      criteria.topicGroup = @topic1.group_name
      criteria.subscriber = subscriber
      request.appID = @app1.appid
      request.criteria = criteria
      p request
      result = ApiBanking::NotificationService.getTopics(request)
      p result
      result.should be_a_match_to_topic([@topic1,@topic2])
      result.should be_a_match_to_subscription([@topic1,@topic2],'1234')
    end

    it "should return all unsubscribed topics for the group & customer specified in the request" do 
      criteria = ApiBanking::NotificationService::GetTopics::ReqCriteria.new()
      request = ApiBanking::NotificationService::GetTopics::Request.new()
      subscriber = ApiBanking::NotificationService::GetTopics::Subscriber.new()
      subscriber.customerID = '1234'
      subscriber.unsubscribed = 'true'
      criteria.topicGroup = @topic1.group_name
      criteria.subscriber = subscriber
      request.appID = @app1.appid
      request.criteria = criteria
      p request
      result = ApiBanking::NotificationService.getTopics(request)
      p result
      result.should be_a_match_to_topic([@topic3,@topic4])
    end
  end
end
