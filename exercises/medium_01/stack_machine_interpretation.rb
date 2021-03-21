# Write a class that implements a miniature stack-and-register-based programming language that has the following commands:

# n - Place a value n in the "register". Do not modify the stack.
# PUSH - Push the register value on to the stack. Leave the value in the register.
# ADD - Pops a value from the stack and adds it to the register value, storing the result in the register.
# SUB - Pops a value from the stack and subtracts it from the register value, storing the result in the register.
# MULT - Pops a value from the stack and multiplies it by the register value, storing the result in the register.
# DIV - Pops a value from the stack and divides it into the register value, storing the integer result in the register.
# MOD - Pops a value from the stack and divides it into the register value, storing the integer remainder of the division in the register.
# POP - Remove the topmost item from the stack and place in register
# PRINT - Print the register value

require 'set'

class ValidateTokenError < StandardError
end

class ValidateStackError < StandardError
end

class Minilang
  TOKENS = Set.new %w(PUSH ADD SUB MULT DIV MOD POP PRINT)

  def initialize(string)
    @commands = string.split
    @stack = []
    @register = 0
  end

  def eval
    @commands.each do |command|
      if value_for_register?(command)
        @register = command.to_i
      else
        validate_token(command)
        send(command.downcase)
      end
    end
  end

  private

  def validate_token(token)
    raise ValidateTokenError, "Invalid token: #{token}" unless TOKENS.include?(token)
  end

  def validate_stack
    raise ValidateStackError, "Empty stack!" if @stack.empty?
  end

  def value_for_register?(n)
    n == n.to_i.to_s
  end

  def stack_pop
    validate_stack
    @stack.pop
  end

  def push
    @stack.push(@register)
  end

  def add
    @register += stack_pop
  end

  def sub
    @register -= stack_pop
  end

  def mult
    @register *= stack_pop
  end

  def div
    @register /= stack_pop
  end

  def mod
    @register %= stack_pop
  end

  def pop
    @register = stack_pop
  end

  def print
    puts @register
  end
end

Minilang.new('PRINT').eval
# 0

Minilang.new('5 PUSH 3 MULT PRINT').eval
# 15

Minilang.new('5 PRINT PUSH 3 PRINT ADD PRINT').eval
# 5
# 3
# 8

Minilang.new('5 PUSH 10 PRINT POP PRINT').eval
# 10
# 5

Minilang.new('5 PUSH POP POP PRINT').eval
# Empty stack!

Minilang.new('3 PUSH PUSH 7 DIV MULT PRINT ').eval
# 6

Minilang.new('4 PUSH PUSH 7 MOD MULT PRINT ').eval
# 12

Minilang.new('-3 PUSH 5 XSUB PRINT').eval
# Invalid token: XSUB

Minilang.new('-3 PUSH 5 SUB PRINT').eval
# 8

Minilang.new('6 PUSH').eval
# (nothing printed; no PRINT commands)
