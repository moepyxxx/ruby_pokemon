class BattlePokemon
  attr_reader :name, :hp, :moves, :level

  def initialize(name, type, moves, level, remainHp: nil)
    @name = name
    @type = type
    @moves = moves
    @level = level
    @hp = remainHp || level * 15
  end

  def is_alive?
    return @hp > 0
  end

  def status
    return "#{@name} (Type: #{@type}, Level: #{@level}) - HP: #{@hp}"
  end

  def take_damage!(damage)
    @hp -= damage
  end
end
