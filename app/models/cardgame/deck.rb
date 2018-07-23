class Deck
  attr_accessor :size
  attr_reader :cards

  def initialize(size)
    @size = size
    @cards = Array.new(size)
  end

  def add_card(card)
    @cards << card
  end
end
