require_relative 'univariate_function'

# This is a class for generic expressions.
# Whereas univariate functions are analogous to named functions
# this is more similar to a lambda. Additionally, this is more
# in the field of CAS instead of numerical analysis. Note:
# This is not at all stable or well tested and exists to try out
# but do not at all rely on this class.
#
# @attr left [Object] the left side of the expression (on a binary operator)
# @attr op [Operator] the binary operator
# @attr right [Object] the right side of the expression
class Expression
  attr_accessor :left, :op, :right

  # The constructor for the class Expression
  #
  # @param [Object] left the left side of the expression
  # @param [Operator] op the binary operator
  # @param [Object] right the right side of the expression
  def initialize(left, op, right)
    @left = left
    @op = op
    @right = right
  end

  # The method missing method for expressions. Using some
  # swanky tricks, a non-extant method on an expression is turned
  # into a binary operator using a symbol and creates a new expression
  # with the left expression being nested into a unit. Thus the expressions
  # are by default left associative.
  #
  # @param [Object] method the method that is missing
  # @param [Object[]] args the args that are passed to the missing method
  # @return a new expression
  def method_missing(method, *args)
    Expression.new(self, method, Variable.new(args[0]))
  end

  # This method returns a flattened list of the variables within an
  # expression. For example, the expression
  # <code>((x + y) + z) + a</code>
  # will have a vars of [x, y, z, a]
  #
  # @return an array of the variables
  def vars
    a = []
    nested?[:left] ? a << left.vars : a << left.x
    nested?[:right] ? a << right.vars : a << right.x
    (a.flatten rescue a).select{|i| String === i}.uniq
  end

  # This method returns a hash describing if the right
  # and/or left sides of an expression are nested.
  #
  # @return a boolean hash with keys [:right, :left]
  def nested?
    {:right => (Expression === right),
     :left => (Expression === left)}
  end

  # This method returns a string version of an expression.
  #
  # @return a string version of an expression
  def to_s
    if nested?[:left]
      s = "#{left.to_s} #{op}"
    else
      s = "#{left} #{op}"
    end
    case right
    when Variable then "#{s} #{right.x}".strip
    when Expression then "#{s} #{right.to_s}".strip
    else "#{s} #{right}".strip
    end
  end

  # This turns the anonymous expression into a function
  #
  # @return a function of the expression.
  def to_func
    if a.vars.size == 1
      blk = ->(intvar) {eval(to_s.gsub(vars[0],'intvar'))}
      UnivariateFunction.new(&blk)
    end
  end
end
