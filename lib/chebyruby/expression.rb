# require_relative 'univariate_function'

class Expression
  attr_accessor :left, :op, :right

  def initialize(left, op, right)
    @left = left
    @op = op
    @right = right
  end

  def method_missing(method, *args)
    Expression.new(self, method, Variable.new(args[0]))
  end

  def vars
    a = []
    nested?[:left] ? a << left.vars : a << left.x
    nested?[:right] ? a << right.vars : a << right.x
    a.flatten
  end

  def nested?
    {:right => (Expression === right),
     :left => (Expression === left)}
  end

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

  def to_func
  end
end
