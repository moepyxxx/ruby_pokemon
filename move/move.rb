class Move 
  attr_reader :name, :type, :power

  def initialize(name, type, power)
    @name = name
    @type = type
    @power = power
  end
end