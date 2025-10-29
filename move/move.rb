class Move 
  attr_reader :name, :type, :power, :max_pp, :condition_effective, :condition_effective_rate

  def initialize(name:, type:, max_pp:, power:, condition_effective: nil, condition_effective_rate: nil)
    @name = name
    @type = type
    @max_pp = max_pp
    @power = power
    @condition_effective = condition_effective
    @condition_effective_rate = condition_effective_rate
  end
end