require_relative 'damage_calculator'
require_relative 'type_effectiveness'
require_relative '../condition/condition'

class MoveEffectiveCalculator
  class << self
    def calculate(move, attacker, receiver)
      if attacker.condition && !attacker.can_move?
        return {
          damage: 0,
          is_critical: false,
          effectiveness: nil,
          condition: attacker.condition,
          is_start_condition_effective: false,
          is_hit: false,
          can_not_move_for_condition: true
        }
      end

      puts "通らないよね？"

      effectiveness = TypeEffectiveness.effectiveness(move.type, receiver.type)
      damage, is_critical = DamageCalculator.calculate(
        attacker_level: attacker.level,
        move_power: move.power,
        effectiveness: effectiveness
      )

      is_start_condition_effective = false
      if !move.condition_effective.nil? && receiver.condition.nil?
        if rand < move.condition_effective_rate
          is_start_condition_effective = true
        end
      end

      return {
        damage:,
        is_critical:,
        effectiveness:,
        condition: is_start_condition_effective ? StatusCondition.create(move.condition_effective) : receiver.condition,
        is_start_condition_effective:,
        is_hit: true
      }
    end
  end
end