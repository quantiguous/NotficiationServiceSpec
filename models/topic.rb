class Topic < ActiveRecord::Base
  self.table_name = "ns_topics"

  has_many :topic_criterias, :foreign_key => 'ns_topic_id', :class_name => "Topic::Criteria"

  def convert_values(code)
    case code
    when 'Y'
      "true"
    when 'N'
      "false"
    end
  end
end
