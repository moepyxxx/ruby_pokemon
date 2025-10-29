require_relative 'damage_calculator'
require_relative 'type_effectiveness'
require_relative '../condition/condition'

class MoveEffectiveCalculator
  class << self
    def calculate(move, attacker, receiver)
      effectiveness = TypeEffectiveness.effectiveness(move.type, receiver.type)
      damage, is_critical = DamageCalculator.calculate(
        attacker_level: attacker.level,
        move_power: move.power,
        effectiveness: effectiveness
      )

      started = nil
      if !move.condition_effective.nil? && receiver.condition.nil?
        if rand < move.condition_effective_rate
          started = StatusCondition.create(move.condition_effective)
        end
      end

      return {
        damage:,
        is_critical:,
        effectiveness:,
        started_condition: started,
        continued_condition: receiver.condition
      }
    end
  end
end