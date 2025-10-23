
require 'forwardable'

class BattleMove
  extend Forwardable
  def_delegators :@move, :name, :type, :power, :max_pp

  attr_reader :current_pp

  def initialize(move, max_pp = nil)
    @move = move
    @current_pp = max_pp || move.max_pp || 10
    puts "Initialized BattleMove: #{move.max_pp}"
    puts "Initialized BattleMove: #{@current_pp}"
  end

  def useable?
    puts  @current_pp > 0
    @current_pp > 0
  end

  def use!
    if !useable?
      raise "PPが足りません！"
    end
    @current_pp -= 1
  end

  def restore_pp!(amount)
    @current_pp += amount
    @current_pp = [@current_pp, @max_pp].min
  end

  def recover_full_pp!
    @current_pp = @max_pp
  end

end