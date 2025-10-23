class Move 
  attr_reader :name, :type, :power, :max_pp

  def initialize(name, type, power, max_pp)
    @name = name
    @type = type
    @power = power
    @max_pp = max_pp
  end
end