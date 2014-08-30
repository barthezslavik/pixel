module BooleanToInteger
  def to_i
    self ? 1 : 0
  end
end

[TrueClass, FalseClass].each { |c| c.send :include, BooleanToInteger }
