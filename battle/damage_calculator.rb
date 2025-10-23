class DamageCalculator
  class << self
    def calculate(attacker_level:, move_power:, effectiveness:)
      is_critical = rand < 0.1
      critical_multiplier = is_critical ? 1.5 : 1
      damage = attacker_level * move_power * effectiveness * critical_multiplier
      return [damage, is_critical]
    end
  end 
end