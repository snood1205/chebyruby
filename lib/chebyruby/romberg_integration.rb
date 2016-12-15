require_relative 'integration'

# This class is for Romberg integration. The Romberg integration method
# involves using Richardson extrapolation combined with the trapezoid
# method to get a more accurate integration method. It was published by
# Werner Romberg in 1955.
# 
# @attr func [UnivariateFunction] the function over which to integrate.
class ChebyRuby::RombergIntegration
  include ChebyRuby::Integration

  attr_accessor :func

  # Basic constructor for RombergIntegration. It can be implemented in two ways.
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

  # This method integrates the function parameter using romberg integration.
  # 
  # @param [Numeric] a the lower bounds of the integral
  # @param [Numeric] b the upper bounds of the integral
  # @param [Integer] iterations the number of iterations to be used for integration.
  def integrate(a, b, iterations = 8)
    t = Array.new(iterations)
    iterations.times do |i|
      t[i] = []
      t[i][0] = trap_integrate(func, a, b, 2 ** i).to_f
    end
    (1...t.length).each do |i|
      (1..i).each do |k|
        t[i][k] = ((4 ** k) * t[i][k-1]  - t[i-1][k-1])/(4**k - 1).to_f
      end
    end
    t.last.last
  end

  # This method compares the accuate of Romberg to other methods.
  # 
  # @param [Numeric] a the lower bounds of the integral
  # @param [Numeric] b the upper bounds of the integral
  # @param [String] method the method to compare to
  # @return [Float] the absolute difference between the two methods.
  def accuracy_comparison(a, b, method = 'Trapezoid')
    super.accuracy_comparison(a, b, method, 'Romberg')
  end
end