ConditionNameMap = {
  burned: "やけど",
  paralysis: "まひ",
  poison: "どく"
}.freeze

module ConditionInterface
  def name
    raise NotImplementedError
  end

  def calculate_damage(hp)
    raise NotImplementedError
  end

  def move_rate
    raise NotImplementedError
  end
end