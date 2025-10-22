
require_relative 'turn_result_interface'

class TurnResult
  include TurnResultInterface

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