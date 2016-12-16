# This is the class for a univariate function.
#
# @attr func [Lambda] the univariate function.
class ChebyRuby::UnivariateFunction
  attr_accessor :func

  # The constructor for the class UnivariateFunction.
  #
  # @param [Lambda] func which represents the function.
  def initialize(&func)
    @func = func
  end

  # This gets the value of the function at a specified value.
  #
  # @param [Numeric] x the value at which the function is evaluated.
  # @return the value of the function at x.
  def value(x)
    func.call(x.to_f)
  end

end
