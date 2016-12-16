require_relative 'expression'

class Variable
  attr_accessor :x, :neg

  def initialize(x)
    @x = x
    @neg = false
  end

  def method_missing(method, *args)
    Expression.new(self, method, Variable.new(args[0]))
  end

  def to_a
    if x.class == Array
      x
    else
      [x]
    end
  end

  def -@
    @neg = true
  end

  def to_enum
    Array.new(to_ary).to_enum
  end

  def right
    nil
  end

  def to_s
    "#{x}"
  end

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

class Array
  def parseable
    Variable.new(self).parseable
  end
end

class Symbol
  def parseable
    self
  end
end
