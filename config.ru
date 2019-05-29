$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'dotenv'
Dotenv.load

require 'slack-ruby-bot'
require 'caas-bot/bot'
require 'web'
require 'json'

SlackRubyBot::Client.logger.level = Logger::INFO

Thread.abort_on_exception = true

Thread.new do
  begin
    CaaSBot::Bot.run
  rescue Exception => e
    STDERR.puts "ERROR: #{e}"
    STDERR.puts e.backtrace
    raise e
  end
end

run CaaSBot::Web
