module ConditionInterface
  def name
    raise NotImplementedError
  end

  def take_damage!(hp)
    raise NotImplementedError
  end

  def can_move?
    raise NotImplementedError
  end
end