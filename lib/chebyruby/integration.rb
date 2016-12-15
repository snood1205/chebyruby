module ChebyRuby::Integration
  def trap_integrate(func, a, b, iterations = 32)
    h = (b - a)/iterations.to_f
    mesh = (a..b).step(h).to_a[1...-1]
    summand = func.value(a) +
        2 * (mesh.map(&func.func).inject(:+) || 0) + func.value(b)
    (b - a)/(2.0 * iterations) * summand
  end

  def accuracy_comparison(a, b, method = 'Trapezoid', cm = 'Trapezoid')
    case method
    when 'Trapezoid' then (integrate(a, b) - trap_integrate(func, a, b)).abs
    when 'Romberg' then (integrate(a, b) - Romberg.sintegrate(func, a, b)).abs
    when 'Simpsons' then (integrate(a, b) - Simpsons.sintegrate(func, a, b)).abs
    end
  end

  class << self
    def sintegrate(func, a, b)
      self.new(func).integrate(a, b)
    end
  end
end
