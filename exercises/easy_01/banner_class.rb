# Complete this class so that the test cases shown below work as intended. You are free to add any methods or instance variables you need. However, do not make the implementation details public.

# You may assume that the input will always fit in your terminal window.

class Banner
  def initialize(message, length)
    @message = message
    @length = length >= 0 && length < @message.length ? length : @message.length
  end

  def to_s
    [horizontal_rule, empty_line, message_line, empty_line, horizontal_rule].join("\n")
  end

  private

  def horizontal_rule
    "+-#{'-' * @length}-+"
  end

  def empty_line
    "| #{' ' * @length} |"
  end

  def message_line
    "| #{@message[0...@length]} |"
  end
end

# banner = Banner.new('To boldly go where no one has gone before.')
# puts banner
# # +--------------------------------------------+
# # |                                            |
# # | To boldly go where no one has gone before. |
# # |                                            |
# # +--------------------------------------------+
#
# banner = Banner.new('')
# puts banner
# # +--+
# # |  |
# # |  |
# # |  |
# # +--+

# FURTHER EXPLORATION: Modify this class so new will optionally let you specify a fixed banner width at the time the Banner object is created. The message in the banner should be centered within the banner of that width. Decide for yourself how you want to handle widths that are either too narrow or too wide.

banner = Banner.new('To boldly go where no one has gone before.', 21)
puts banner

banner = Banner.new('To boldly go where no one has gone before.', 50)
puts banner

banner = Banner.new('', 0)
puts banner
