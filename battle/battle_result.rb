
require_relative 'result_interface'

class BattleResult
  include ResultInterface

  def initialize(winner, loser)
    @winner = winner
    @loser = loser
  end

  def message
    return [
      "#{@loser.name}はたおれた！",
      "#{@winner.name}のかちだ！"
    ]
  end
end