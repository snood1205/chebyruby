require_relative 'differentiation'
class ChebyRuby::FiniteDifferencing
  include Differentiation

  attr_accessor :func

  def initialize(func)
    @func = func
  end

  def forward(x, h = 0.1, order = 1)
    (0..order).map do |i|
      (-1)**i * FiniteDifferencing::binomial(order, i) *
      func.value(x + (order - i) * h)
    end.inject(:+) / (h**order).to_f
  end

  def backward(x, h = 0.1, order = 1)
    (0..order).map do |i|
      (-1)**i * FiniteDifferencing::binomial(order, i) *
      func.value(x - i * h)
    end.inject(:+) / (h**order).to_f
  end

  def central(x, h = 0.1, order = 1)
    (0..order).map do |i|
      (-1)**i * FiniteDifferencing::binomial(order, i) *
      func.value(x + (order/2.0 - i) * h)
    end.inject(:+) / (h**order).to_f
  end

  private
  def FiniteDifferencing.binomial(n, k)
    (1..k).map do |i|
      (n + 1 - i)/i.to_f
    end.inject(:*) || 1
  end
end