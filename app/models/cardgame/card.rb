class Card
  attr_accessor :value, :color, :symbol

  def initialize(value, color, symbol)
    @value = value
    @color = color
    @symbol = symbol
  end

  def ==(other)
    value == other.value
  end

  def ===(other)
    value == other.value && symbol == other.symbol
  end

  def >(other)
    value > other.value
  end

  def <(other)
    value < other.value
  end
end
