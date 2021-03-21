# Your task is to write a CircularQueue class that implements a circular queue for arbitrary objects. The class should obtain the buffer size with an argument provided to CircularQueue::new, and should provide the following methods:
# enqueue to add an object to the queue
# dequeue to remove (and return) the oldest object in the queue. It should return nil if the queue is empty.
# You may assume that none of the values stored in the queue are nil (however, nil may be used to designate empty spots in the buffer).

# class CircularQueue
#   def initialize(length)
#     @buffer = Array.new(length)
#     @max_length = length
#     @counter = 0
#   end
#
#   def enqueue(num)
#     @buffer[current_idx] = num
#     @counter += 1
#   end
#
#   def dequeue
#     value = @buffer[oldest_idx]
#     @buffer[oldest_idx] = nil
#     value
#   end
#
#   private
#
#   def number_filled
#     @max_length - @buffer.count(nil)
#   end
#
#   def current_idx
#     @counter % @max_length
#   end
#
#   def oldest_idx
#     current_idx - number_filled
#   end
# end

# FURTHER EXPLORATION: Phew. That's a lot of work, but it's a perfectly acceptable solution to this exercise. However, there is a simpler solution that uses an Array, and the #push and #shift methods.

class CircularQueue
  def initialize(length)
    @buffer = Array.new
    @max_length = length
  end

  def enqueue(num)
    dequeue if full?
    @buffer.push(num)
    self
  end

  def dequeue
    @buffer.shift
  end

  private

  def full?
    @buffer.length == @max_length
  end
end

queue = CircularQueue.new(3)
puts queue.dequeue == nil

queue.enqueue(1)
queue.enqueue(2)
puts queue.dequeue == 1

queue.enqueue(3)
queue.enqueue(4)
puts queue.dequeue == 2

queue.enqueue(5)
queue.enqueue(6)
queue.enqueue(7)
puts queue.dequeue == 5
puts queue.dequeue == 6
puts queue.dequeue == 7
puts queue.dequeue == nil

queue = CircularQueue.new(4)
puts queue.dequeue == nil

queue.enqueue(1)
queue.enqueue(2)
puts queue.dequeue == 1

queue.enqueue(3)
queue.enqueue(4)
puts queue.dequeue == 2

queue.enqueue(5)
queue.enqueue(6)
queue.enqueue(7)
puts queue.dequeue == 4
puts queue.dequeue == 5
puts queue.dequeue == 6
puts queue.dequeue == 7
puts queue.dequeue == nil
