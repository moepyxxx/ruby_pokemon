require_relative 'condition_interface'

class Condition 
  class Burned
    include ConditionInterface

    def name
      :burned
    end

    def calculate_damage(hp)
      hp - (hp / 10)
    end

    def move_rate
      1
    end
  end
end