require_relative 'integration'

class ChebyRuby::SimpsonsIntegration
  include ChebyRuby::Integration

  attr_accessor :func

  def initialize(func)
    @func = func
  end

  def integrate(a, b, iterations = 32)
    h = (b - a) / iterations.to_f
    mesh = (a..b).step(h).to_a[1...-1]
    even = mesh.each_with_index.select{|i, j| j.odd?}.map(&:first)
    odd = mesh.each_with_index.select{|i, j| j.even?}.map(&:first)
    summand = func.value(a) + func.value(b) +
        2 * even.map(&func.func).inject(:+) + 4 * odd.map(&func.func).inject(:+)
    (h / 3.0) * summand
  end

  def accuracy_comparison(a, b, method = 'Trapezoid')
    super.accuracy_comparison(a, b, method, 'RombergIntegration')
  end
end