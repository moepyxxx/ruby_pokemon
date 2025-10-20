class Pokemon 
  def initialize(name, type, max_hp)
    @name = name
    @type = type
    @hp = max_hp
  end

  def is_alive?
    return @hp > 0
  end

  def status
    return "#{@name} (Type: #{@type}) - HP: #{@hp}"
  end

  def take_damage(damage)
    @hp -= damage
  end

  def special_move
    raise NotImplementedError, "サブクラスで実装してください"
  end
end
