require_relative '../ui'
require_relative 'type_effectiveness'
require_relative 'move_result'
require_relative 'damage_calculator'

class MoveTurn
  def initialize(attacker, receiver, move)
    @attacker = attacker
    @receiver = receiver
    @move = move
  end

  def execute!
    effectiveness = TypeEffectiveness.effectiveness(@move.type, @receiver.type)
    damage = DamageCalculator.calculate(
      attacker_level: @attacker.level,
      move_power: @move.power,
      effectiveness: effectiveness
    )
    @receiver.take_damage!(damage)

    {
      damage:,
      effectiveness:
    }
  end
end