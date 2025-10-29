
require_relative 'result_interface'
require_relative '../type_effectiveness'

class MoveResult
  include ResultInterface

  def initialize(attacker:, receiver:, move:, damage:, effectiveness:, is_critical:, started_condition:, continued_condition:)
    @attacker = attacker
    @receiver = receiver
    @move = move
    @damage = damage
    @effectiveness = effectiveness
    @is_critical = is_critical
    @started_condition = started_condition
    @continued_condition = continued_condition
  end

  def message
    message = [
      "#{@attacker.name}の#{@move.name}！",
      "#{@receiver.name}に#{@damage}のダメージ！",
    ]

    message << "きゅうしょにあたった！" if @is_critical
    message << "効果はばつぐんだ" if @effectiveness == TypeEffectiveness::SUPER
    message << "効果はいまひとつだ" if @effectiveness == TypeEffectiveness::NOT_VERY
    message << "#{@receiver.name}は#{@started_condition.name}になった！" if @started_condition
    return message
  end
end