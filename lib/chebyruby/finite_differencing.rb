require_relative 'differentiation'

# This is the class for finite differencing.
# Finite differencing is a popular method of finding a numeric
# derivative. There are three different implementations of the finite
# differencing method. There is the forward and backward implementations,
# both with an order of accuracy of O(h) and central differencing with an
# order of accuracy of O(h^2). 
# 
# @attr func [UnivariateFunction] the function to which differentiation will be applied
class ChebyRuby::FiniteDifferencing
  include Differentiation

  attr_accessor :func

  # Basic constructor for FiniteDifferencing. It can be implemented in two ways.
  # It can either have a UnivariateFunction passed to it or a proc. 
  # 
  # @param [UnivariateFunction||Proc] func the function to implement
  def initialize(func)
    if func.is_a? Proc
      @func = UnivariateFunction.new(&func)
    else
      @func = func
    end
  end

  # This does forward finite differencing. 
  # The formula being used is:
  # <pre> Sum[(-1)^i * Binom(n i) * f(x + (n-i) * h), {i, 0, n}]/(h^n) </pre>
  # 
  # @param [Numeric] x the value at which to find the derivative
  # @param [Numeric] h the value to use for the differencing (generally 
  # the smaller the better with exceptions especially when considering 
  # underflow).
  # @param [Integer] order the order of the derivative. (Ex. 1 for f', 2 for f'', etc.)
  # @return [Float] the forward finite differencing approximation of f^(n) (x)
  def forward(x, h = 0.1, order = 1)
    (0..order).map do |i|
      (-1)**i * FiniteDifferencing::binomial(order, i) *
      func.value(x + (order - i) * h)
    end.inject(:+) / (h**order).to_f
  end

  # This does backward finite differencing. 
  # The formula being used is:
  # <pre> Sum[(-1)^i * Binom(n i) * f(x - i*h), {i, 0, n}]/(h^n) </pre>
  # 
  # @param [Numeric] x the value at which to find the derivative
  # @param [Numeric] h the value to use for the differencing (generally 
  # the smaller the better with exceptions especially when considering 
  # underflow).
  # @param [Integer] order the order of the derivative. (Ex. 1 for f', 2 for f'', etc.)
  # @return [Float] the backward finite differencing approximation of f^(n) (x)
  def backward(x, h = 0.1, order = 1)
    (0..order).map do |i|
      (-1)**i * FiniteDifferencing::binomial(order, i) *
      func.value(x - i * h)
    end.inject(:+) / (h**order).to_f
  end

  # This does central finite differencing. 
  # The formula being used is:
  # <pre> Sum[(-1)^i * Binom(n i) * f(x + (n/2-i) * h), {i, 0, n}]/(h^n) </pre>
  # 
  # @param [Numeric] x the value at which to find the derivative
  # @param [Numeric] h the value to use for the differencing (generally 
  # the smaller the better with exceptions especially when considering 
  # underflow).
  # @param [Integer] order the order of the derivative. (Ex. 1 for f', 2 for f'', etc.)
  # @return [Float] the central finite differencing approximation of f^(n) (x)
  def central(x, h = 0.1, order = 1)
    (0..order).map do |i|
      (-1)**i * FiniteDifferencing::binomial(order, i) *
      func.value(x + (order/2.0 - i) * h)
    end.inject(:+) / (h**order).to_f
  end

  private
  # Used to calculate the binomial coefficient.
  # 
  # @param [Integer] n the upper binomial value
  # @param [Integer] k the lowe binomial value
  # @return [Float] Binom(n k)
  def FiniteDifferencing.binomial(n, k)
    (1..k).map do |i|
      (n + 1 - i)/i.to_f
    end.inject(:*) || 1
  end
end