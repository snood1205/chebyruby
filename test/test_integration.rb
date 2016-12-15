require 'minitest/autorun'
require 'chebyruby'

class TestIntegration < Minitest::Test
  include ChebyRuby::Integration
  def setup
    @sin = ChebyRuby::UnivariateFunction.new {|x| Math.sin(x)}
    @exp = ChebyRuby::UnivariateFunction.new {|x| Math.exp(x)}
    @pol = ChebyRuby::UnivariateFunction.new {|x| x**2 + 2*x + 1}
    @x   = ChebyRuby::UnivariateFunction.new {|x| x}
  end

  def test_integration
    assert_in_delta 0, trap_integrate(@sin, 0, Math::PI * 2), 1e-8
  end
end
