
require_relative 'result_interface'
require_relative '../type_effectiveness'

class MoveResult
  include ResultInterface

  def initialize(attacker, defender, move, damage, effectiveness, is_critical)
    @attacker = attacker
    @defender = defender
    @move = move
    @damage = damage
    @effectiveness = effectiveness
    @is_critical = is_critical
  end

  def message
    message = [
      "#{@attacker.name}の#{@move.name}！",
      "#{@defender.name}に#{@damage}のダメージ！",
    ]

    message << "きゅうしょにあたった！" if @is_critical
    message << "効果はばつぐんだ" if @effectiveness == TypeEffectiveness::SUPER
    message << "効果はいまひとつだ" if @effectiveness == TypeEffectiveness::NOT_VERY
    return message
  end
end