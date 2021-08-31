# frozen_string_literal: true

# class for a player object. Using to distinguish between P1 and P2
class Player
  attr_reader :name

  def initialize(name)
    @name = name
  end
end
