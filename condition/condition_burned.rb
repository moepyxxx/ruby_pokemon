require_relative 'condition_interface'

class Condition 
  class Burned
    include ConditionInterface

    def name
      :burned
    end

    def take_damage!(hp)
      hp - (hp / 10)
    end

    def can_move?
      true
    end
  end
end