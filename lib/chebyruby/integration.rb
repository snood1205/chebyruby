# Module/Mixin for integration.
# 
# It is currently mixed into Romberg and Simpson's
module ChebyRuby::Integration

  # This method returns the trapezoid integration estimate.
  # 
  # @param [UnivariateFunction] func the univariate function to integrate
  # @param [Numeric] a the lower bounds of the integral
  # @param [Numeric] b the upper bounds of the integral
  # @param [Integer] iterations the number of iterations/subregions requested.
  # While a higher number will be more accurate, it will also take longer.
  # @return [Float] the trapezoidal estimation of the integral of func from
  # a to b.
  def trap_integrate(func, a, b, iterations = 32)
    h = (b - a)/iterations.to_f
    mesh = (a..b).step(h).to_a[1...-1]
    summand = func.value(a) +
        2 * (mesh.map(&func.func).inject(:+) || 0) + func.value(b)
    (b - a)/(2.0 * iterations) * summand
  end

  # This method compares the accuate of certain methods to each other.
  # 
  # @param [Numeric] a the lower bounds of the integral
  # @param [Numeric] b the upper bounds of the integral
  # @param [String] method the method being used
  # @param [String] cm the method to compare to
  # @return [Float] the absolute difference between the two methods.
  def accuracy_comparison(a, b, method = 'Trapezoid', cm = 'Trapezoid')
    case method
    when 'Trapezoid' then (integrate(a, b) - trap_integrate(func, a, b)).abs
    when 'Romberg' then (integrate(a, b) - Romberg.sintegrate(func, a, b)).abs
    when 'Simpsons' then (integrate(a, b) - Simpsons.sintegrate(func, a, b)).abs
    end
  end

  # Singleton class for mixin purposes.
  class << self
    # This method provides a singleton implementation of an
    # integration method in an integration class.
    # 
    # @param [UnivariateFunction] func the function over which to integrate
    # @param [Numeric] a the lower bounds of the integral
    # @param [Numeric] b the upper bounds of the integral
    def sintegrate(func, a, b)
      self.new(func).integrate(a, b)
    end
  end
end
