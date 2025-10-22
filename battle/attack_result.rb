
require_relative 'turn_result_interface'

class AttackResult
  include TurnResultInterface

  def initialize(attacker, defender, damage)
    @attacker = attacker
    @defender = defender
    @damage = damage
  end

  def message
    return [
      "#{@attacker.name}の#{@attacker.special_move}！",
      "#{@defender.name}に#{@damage}のダメージ！",
    ]
  end
end