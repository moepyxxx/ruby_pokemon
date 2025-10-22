class TypeEffectiveness
  SUPER = 2.0
  NOT_VERY = 0.5
  NORMAL = 1.0

  EFFECTIVENESS = {
    :fire => {
      :grass => SUPER,
      :water => NOT_VERY,
      :fire => NOT_VERY,
      :normal => NORMAL
    },
    :water => {
      :fire => SUPER,
      :grass => NOT_VERY,
      :water => NOT_VERY,
      :normal => NORMAL
    },
    :grass => {
      :water => SUPER,
      :fire => NOT_VERY,
      :grass => NOT_VERY,
      :normal => NORMAL
    },
    :normal => {
      :fire => NORMAL,
      :water => NORMAL,
      :grass => NORMAL,
      :normal => NORMAL
    }
  }.freeze

  class << self
    def effectiveness(attacker_type, defender_type)
      EFFECTIVENESS[attacker_type][defender_type] || NORMAL
    end
  end
end