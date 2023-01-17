# frozen_string_literal: true

# event counter class
class Record
  def initialize
    @events = {}
  end

  def insert(value)
    if @events.key?(value)
      @events[value][:count] += 1
      return
    end

    @events[value] = { count: 1, time: Time.now }
  end

  def clear_cache
    return if @events.empty?

    @events.select! { |_k, value| Time.now - value[:time] < 5 }
  end

  def events
    clear_cache
    @events.transform_values { |v| v[:count] }
  end
end

# AC
# Count events inserted 
# clear out events that are older than 5 seconds
# events return events counted for the past 5 seconds

record = Record.new
record.insert('e1')
record.insert('e1')
record.insert('e2')

# { e1: 2, e2: 1 }
puts record.events

puts 'sleeping...'
sleep(10)

# { }
puts record.events

record.insert('e1')

# { e1: 1 }
puts record.events
