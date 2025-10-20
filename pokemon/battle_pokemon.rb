class BattlePokemon
  attr_reader :name, :hp

  def initialize(name, type, moves = [], level, remainHp)
    @name = name
    @type = type
    @moves = moves
    @level = level
    @hp = remainHp
  end

  def special_move
    return @moves.first
  end

  def is_alive?
    return @hp > 0
  end

  def status
    return "#{@name} (Type: #{@type}, Level: #{@level}) - HP: #{@hp}"
  end

  def take_damage(damage)
    @hp -= damage
  end
end
