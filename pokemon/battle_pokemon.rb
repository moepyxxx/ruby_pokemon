class BattlePokemon
  attr_reader :name, :type, :hp, :moves, :level, :condition

  def initialize(name, type, moves, level, remainHp: nil)
    @name = name
    @type = type
    @moves = moves
    @level = level
    @hp = remainHp || level * 15
    @condition = nil
  end

  def status
    return "#{@name} (Type: #{@type}, Level: #{@level}) - HP: #{@hp} Condition: #{@condition || 'Normal'}"
  end

  def take_damage!(damage)
    @hp -= damage
  end
  
  def apply_condition!(condition)
    @condition = condition
  end

  def can_move?
    return true if @condition.nil?
    rand < @condition.move_rate
  end
end
