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

    if result[:is_start_condition_effective] && result[:condition]
      @receiver.apply_condition!(result[:condition])
    end

    if result[:condition]
      @receiver.take_damage!(result[:condition].calculate_damage(@receiver.hp))
    end

    @move.use!

    {
      damage: result[:damage],
      effectiveness: result[:effectiveness],
      is_critical: result[:is_critical],
      condition: result[:condition],
      is_start_condition_effective: result[:is_start_condition_effective],
      is_hit: result[:is_hit],
      can_not_move_for_condition: result[:can_not_move_for_condition]
    }
  end
end