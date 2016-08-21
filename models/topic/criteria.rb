require_relative '../topic'
class Topic::Criteria < ActiveRecord::Base
  self.table_name = "ns_topic_criteria"
end
