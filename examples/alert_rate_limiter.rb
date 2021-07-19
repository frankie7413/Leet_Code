# Alert Rate Limiter:
# Question:
# We have a monitoring system that send out alert when there is an error.
# 1. Can you implement a feature that same error will not be sent again within 5 seconds.
# 2. Write a class with proper initialization and a `shouldAlert` method returns True/False

# Verification:
 
# import time
# logger = Logger(5);
# print logger.shouldAlert("foo") #returns true;
# print logger.shouldAlert("bar") #returns true;
# print logger.shouldAlert("foo") #returns false;
# print logger.shouldAlert("bar") #returns false;
# print logger.shouldAlert("foo") #returns false;
# time.sleep(5)
# print logger.shouldAlert("foo"); returns true;

class Logger
  def initialize(size)
    @cache_size = size 
    @logs = {}
  end

  def time_out?(log_time)
    (Time.now - log_time) < 5 
  end

  def should_alert(msg)
    return false unless valid_message?(msg)

    clear_cache
    @logs[msg.to_sym] = Time.now
    true
  end

  def valid_message?(msg)
    log_time = @logs[msg.to_sym]
    return false if !log_time.nil? && time_out?(log_time) 

    true
  end

  def clear_cache
    return if @logs.empty? || @logs.size < @cache_size || @logs.size == 1

    @logs.sort_by { |k,v| v }.to_h
    @logs.shift
  end
end

def format_result(msg, alert, assertion)
  puts "Running with #{msg}..."
  return puts "Error expected: #{assertion} but recived: #{alert}" if alert != assertion

  puts "Success"
end

puts "First Set of Test Cases - No Cache check"
logger = Logger.new(5)
format_result('foo', logger.should_alert('foo'), true)
format_result('bar', logger.should_alert('bar'), true)
format_result('foo', logger.should_alert('foo'), false)
format_result('bar', logger.should_alert('bar'), false)
puts '...Sleeping for 5 seconds'
sleep(5)
format_result('foo', logger.should_alert('foo'), true)
format_result('bar', logger.should_alert('bar'), true)

# 2. Can you clean up old cache every time `should_alert` method is triggered
# assumption:
# pop the oldest log by time when new log entries are going to be added to keep cache size limit?

puts "\n\nSecond Set of Test Cases - Cache Check"
logger = Logger.new(5)
format_result('foo', logger.should_alert('foo'), true)
format_result('bar', logger.should_alert('bar'), true)
format_result('foo2', logger.should_alert('foo2'), true)
format_result('bar2', logger.should_alert('bar2'), true)
format_result('foo3', logger.should_alert('foo3'), true)
puts '...Removing Old Cache Value'
format_result('foo4', logger.should_alert('foo4'), true)
format_result('bar3', logger.should_alert('bar3'), true)
puts '...re-added to hash return true under 5 seconds'
format_result('foo', logger.should_alert('foo'), true)
format_result('bar', logger.should_alert('bar'), true)
puts '...return false under 5 seconds'
format_result('foo', logger.should_alert('foo'), false)
format_result('bar', logger.should_alert('bar'), false)
