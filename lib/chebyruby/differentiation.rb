module ChebyRuby::Differentiation
  def slope(func, a, b)
    (func.value(b) - func.value(a))/(b-a)
  end
end