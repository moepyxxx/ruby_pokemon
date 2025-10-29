require_relative 'condition_interface'

class Condition 
  class Poison
    include ConditionInterface

    def name
      :poison
    end

    def calculate_damage(hp)
      hp - (hp / 10)
    end

    def can_move?
      true
    end
  end
end