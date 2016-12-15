require_relative 'integration'

class ChebyRuby::RombergIntegration
  include ChebyRuby::Integration

  attr_accessor :func

  def initialize(func)
    @func = func
  end

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

  def accuracy_comparison(a, b, method = 'Trapezoid')
    super.accuracy_comparison(a, b, method, 'RombergIntegration')
  end
end