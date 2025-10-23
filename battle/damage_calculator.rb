class DamageCalculator
  class << self
    def calculate(attacker_level:, move_power:, effectiveness:)
      damage = attacker_level * move_power * effectiveness
      return damage
    end
  end 
end