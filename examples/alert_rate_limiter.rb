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
    @logs = []
  end

  def timeout?(log_time)
    (Time.now - log_time) < 5 
  end

  def shouldAlert(msg)
    return false if @logs.any? { |log| log[:msg] == msg && timeout?(log[:time]) }  

    clear_cache 
    @logs << { msg: msg, time: Time.now }
    true
  end

  def clear_cache
    return if @logs.empty? || @logs.size < @cache_size || @logs.size == 1
    @logs.sort_by! { |log| log[:time] }.shift
  end
end

def format_result(msg, alert, assertion)
  puts "Running with #{msg}..."
  return puts "Error expected: #{assertion} but recived: #{alert}" if alert != assertion

  puts "Success"
end

logger = Logger.new(5)
format_result('foo', logger.shouldAlert('foo'), true)
format_result('bar', logger.shouldAlert('bar'), true)
format_result('foo', logger.shouldAlert('foo'), false)
format_result('bar', logger.shouldAlert('bar'), false) 
puts '...Sleeping for 5 seconds'
sleep(5)
format_result('foo', logger.shouldAlert('foo'), true)

# 2. Can you clean up old cache every time `shouldAlert` method is triggered
# assuming this will pop the oldest elment each call? 
puts "\n\nSecond Set of Test Cases"
logger = Logger.new(4)
format_result('foo', logger.shouldAlert('foo'), true)
format_result('bar', logger.shouldAlert('bar'), true)
format_result('foo2', logger.shouldAlert('foo2'), true)
format_result('bar2', logger.shouldAlert('bar2'), true) 
format_result('foo3', logger.shouldAlert('foo3'), true) 
puts '...Removing Old Cache Value'
format_result('foo', logger.shouldAlert('foo'), true)
format_result('bar', logger.shouldAlert('bar'), true)
