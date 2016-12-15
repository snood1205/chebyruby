# Module/Mixin for numeric differentiation methods. 
# As of right now it is only mixed-in to @see [FiniteDifferencing]
# but will likely be mixed into more in the future. 
module ChebyRuby::Differentiation

  # A crude method to calculate the "slope" of a function over the 
  # span of two points.
  # The formula used is:
  # <pre>(f(b) - f(a))/(b - a)</pre>
  # 
  # @param [UnivariateFunction] func the univariate function to be used.
  # @param [Numeric] a one of the values in the domain of func
  # @param [Numeric] b the other value in the domain of func
  # @return [Float] the slope as described above 
  def slope(func, a, b)
    (func.value(b) - func.value(a))/(b-a).to_f
  end
end