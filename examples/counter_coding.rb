# frozen_string_literal: true

# counter tracking class
class Record
  def intialize; end
end

# AC
# Count events inserted 
# clear out events that are older than 5 minutes 
# events return events counted for the past 5 minutes 

record = Record.new
record.insert('e1')
record.insert('e1')
record.insert('e2')

# { e1: 2, e2: 1 }
puts record.events

sleep(10)

# { }
puts record.events

record.insert('e1')

# { e1: 1 }
puts record.events
