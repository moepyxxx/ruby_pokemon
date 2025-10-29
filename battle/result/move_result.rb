
require_relative 'result_interface'
require_relative '../type_effectiveness'
require_relative 'condition_start_result'
require_relative 'can_not_move_for_condition_result'
require_relative 'take_damage_for_condition_result'

class MoveResult
  include ResultInterface

  def initialize(
    attacker:,
    receiver:,
    move:,
    damage:,
    effectiveness:,
    is_critical:,
    condition:,
    is_start_condition_effective:,
    is_hit:,
    can_not_move_for_condition: false
  )
    @attacker = attacker
    @receiver = receiver
    @move = move
    @damage = damage
    @effectiveness = effectiveness
    @is_critical = is_critical
    @condition = condition
    @is_start_condition_effective = is_start_condition_effective
    @is_hit = is_hit
    @can_not_move_for_condition = can_not_move_for_condition
  end

  def message
    if !@is_hit && @can_not_move_for_condition
      return CanNotMoveForConditionResult.new(@attacker, @attacker.condition).message
    end

    message = [
      "#{@attacker.name}の#{@move.name}！",
      "#{@receiver.name}に#{@damage}のダメージ！",
    ]

    message << "きゅうしょにあたった！" if @is_critical
    message << "効果はばつぐんだ" if @effectiveness == TypeEffectiveness::SUPER
    message << "効果はいまひとつだ" if @effectiveness == TypeEffectiveness::NOT_VERY
    message+= ConditionStartResult.new(@receiver, @condition).message if @condition && @is_start_condition_effective
    message+= TakeDamageForConditionResult.new(@receiver, @condition).message if @condition
    message
  end
end