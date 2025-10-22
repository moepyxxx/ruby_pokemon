
require_relative 'turn_result_interface'

class AttackResult
  include TurnResultInterface

  def initialize(attacker, defender, move, damage)
    @attacker = attacker
    @defender = defender
    @move = move
    @damage = damage
  end

  def message
    return [
      "#{@attacker.name}の#{@move.name}！",
      "#{@defender.name}に#{@damage}のダメージ！",
    ]
  end
end