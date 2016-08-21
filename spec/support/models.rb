require 'active_record'

ActiveRecord::Base.establish_connection(
  adapter: "oracle_enhanced",
  database: ENV['DATABASE'],
  username: ENV['DB_USERNAME'],
  password: ENV['DB_PASSWORD']
)

RSpec.configure do |config|
  config.before(:suite) do
    Dir[File.expand_path('../../models', File.dirname(__FILE__)) + "/**/*.rb"].each { |f| require f }
  end
end

