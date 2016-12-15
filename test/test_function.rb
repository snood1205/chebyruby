require 'minitest/autorun'
require 'chebyruby'

class TestFunction < Minitest::Test
  def setup
    @sin = ChebyRuby::UnivariateFunction.new {|x| Math.sin(x)}
    @exp = ChebyRuby::UnivariateFunction.new {|x| Math.exp(x)}
    @pol = ChebyRuby::UnivariateFunction.new {|x| x**2 + 2*x + 1}
  end

  def test_functions_return_floats
    assert_kind_of Float, @sin.value(rand)
    assert_kind_of Float, @exp.value(rand)
    assert_kind_of Float, @pol.value(rand)
  end

  def test_functions_return_floats_with_integer_parameters
    assert_kind_of Float, @sin.value(1)
    assert_kind_of Float, @exp.value(0)
    assert_kind_of Float, @pol.value(0)
  end

  def test_functions_return_expected_values
    assert_in_delta 0, @sin.value(0), 1e-8
    assert_in_delta 0, @sin.value(Math::PI), 1e-8
    assert_in_delta 1, @exp.value(0), 1e-8
    assert_in_delta Math::E, @exp.value(1), 1e-8
    z = rand
    assert_in_delta (Math::E ** z), @exp.value(z), 1e-8
    assert_in_delta 1, @pol.value(0), 1e-8
    assert_in_delta 4, @pol.value(1), 1e-8
    f = -> (x) {x**2 + 2*x + 1}
    assert_in_delta f.call(z), @pol.value(z), 1e-8
  end
end