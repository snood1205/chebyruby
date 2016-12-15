require_relative 'integration'

# This class is for the composite Simpson's rule. The Composite Simpson's rule
# involves summing Simpson's rule being calculated over a fine mesh.
# 
# @attr func [UnivariateFunction] the function over which to integrate.
class ChebyRuby::SimpsonsIntegration
  include ChebyRuby::Integration

  attr_accessor :func

  # Basic constructor for SimpsonsIntegration. It can be implemented in two ways.
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

  # This method integrates the function parameter using 
  # the composite simpsons rule.
  # 
  # @param [Numeric] a the lower bounds of the integral
  # @param [Numeric] b the upper bounds of the integral
  # @param [Integer] iterations the number of iterations to be used for integration.
  def integrate(a, b, iterations = 32)
    h = (b - a) / iterations.to_f
    mesh = (a..b).step(h).to_a[1...-1]
    even = mesh.each_with_index.select{|i, j| j.odd?}.map(&:first)
    odd = mesh.each_with_index.select{|i, j| j.even?}.map(&:first)
    summand = func.value(a) + func.value(b) +
        2 * even.map(&func.func).inject(:+) + 4 * odd.map(&func.func).inject(:+)
    (h / 3.0) * summand
  end

  # This method compares the accuate of Simpsons to other methods.
  # 
  # @param [Numeric] a the lower bounds of the integral
  # @param [Numeric] b the upper bounds of the integral
  # @param [String] method the method to compare to
  # @return [Float] the absolute difference between the two methods.
  def accuracy_comparison(a, b, method = 'Trapezoid')
    super.accuracy_comparison(a, b, method, 'Simpsons')
  end 
end