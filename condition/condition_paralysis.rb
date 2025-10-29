require_relative 'condition_interface'

class Condition 
  class Paralysis
    include ConditionInterface

    def name
      :paralysis
    end

    def calculate_damage(hp)
      0
    end

    def move_rate
      0.5
    end
  end
end