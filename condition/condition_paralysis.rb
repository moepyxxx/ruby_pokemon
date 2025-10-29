require_relative 'condition_interface'

class Condition 
  class Paralysis
    include ConditionInterface

    def name
      :paralysis
    end

    def take_damage!(hp)
      hp
    end

    def can_move?
      rand < 0.75
    end
  end
end