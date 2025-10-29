require_relative '../ui'
require_relative 'damage_calculator'
require_relative 'move_effective_calculator'

class MoveTurn
  def initialize(attacker, receiver, move)
    @attacker = attacker
    @receiver = receiver
    @move = move
  end

  def execute!
    result = MoveEffectiveCalculator.calculate(@move, @attacker, @receiver)
    @receiver.take_damage!(result[:damage])

    if result[:started_condition]
      @receiver.apply_condition!(result[:started_condition])
    end

    if result[:continued_condition]
      @receiver.take_damage!(result[:continued_condition].calculate_damage(@receiver.hp))
    end

    @move.use!

    {
      damage: result[:damage],
      effectiveness: result[:effectiveness],
      is_critical: result[:is_critical],
      started_condition: result[:started_condition],
      continued_condition: result[:continued_condition]
    }
  end
end