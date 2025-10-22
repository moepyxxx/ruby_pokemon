
require_relative 'turn_result_interface'
require_relative 'type_effectiveness'

class AttackResult
  include TurnResultInterface

  def initialize(attacker, defender, move, damage, effectiveness)
    @attacker = attacker
    @defender = defender
    @move = move
    @damage = damage
    @effectiveness = effectiveness
  end

  def message
    message = [
      "#{@attacker.name}の#{@move.name}！",
      "#{@defender.name}に#{@damage}のダメージ！",
    ]

    message << "効果はばつぐんだ" if @effectiveness == TypeEffectiveness::SUPER
    message << "効果はいまひとつだ" if @effectiveness == TypeEffectiveness::NOT_VERY
    return message
  end
end