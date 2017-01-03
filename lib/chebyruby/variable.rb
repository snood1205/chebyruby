require_relative 'expression'

# This is the class for a variable in an expression. It is part of the 
# CAS side-project in ChebyRuby.
#
# @attr x [String] the variable name
# @attr neg [Boolean] the negation status of the variable
class Variable
  attr_accessor :x, :neg

  # This is the constructor for the variable class
  #
  # @param [String] x the variable name to initialize
  # @param [Boolean] neg the negation status of the variable
  def initialize(x, neg = false)
    @x = x
    @neg = false
  end

  # This variadic method missing works with Expression's method missing
  # to construct and expression from variables.
  #
  # @param [Object] method the method that is missing
  # @param [Object[]] args the args that are passed to the missing method
  # @return a new expression
  def method_missing(method, *args)
    Expression.new(self, method, Variable.new(args[0]))
  end

  # This method will turn a variadic variable into an array
  #
  # @return an array of the variable
  def to_a
    if x.class == Array
      x
    else
      [x]
    end
  end

  # This is an overriding of the unary negation operation that allows for
  # negation of a variable as simply as -x.
  #
  # @return a negated form of the current variable
  def -@
    Variable.new(@x, !@neg)
  end

  # This turns the current array variable into an enumerator
  #
  # @return an enumerated form of the array variable
  def to_enum
    Array.new(to_ary).to_enum
  end

  # A nil returning function for the purposes of expression building
  #
  # @return nil
  def right
    nil
  end

  # A basic to_s function
  #
  # @return a string
  def to_s
    "#{x}"
  end

  # Returns a parseable version of the variable/expression for
  # computer system modification.
  #
  # @return parseable form
  def parseable
    to_enum.map do |i|
      if Array === i
        i.parseable
      elsif Symbol === i
        i
      else
        i.x
      end
    end
  end

  alias to_ary to_a
end

# Open class array
class Array
  # Public help for Variable#parseable
  def parseable
    Variable.new(self).parseable
  end
end

# Open class Symbol
class Symbol
  # Public help for Variable#parseable
  def parseable
    self
  end
end
