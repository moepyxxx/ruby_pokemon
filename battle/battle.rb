require_relative '../pokemon/battle_pokemon'
require_relative './result/introduction_result'
require_relative './result/battle_result'
require_relative './result/status_result'
require_relative 'move_turn'
require_relative './result/move_result'

class Battle
  def initialize(player_pokemon, enemy_pokemon)
    @player_pokemon = player_pokemon
    @enemy_pokemon = enemy_pokemon
    @player_turn = true
    @current_player_pokemon_move = nil
    @current_enemy_pokemon_move = nil
  end

  def execute
    introduction

    while battle_in_progress?
      status

      select_move if @player_turn
      manual_select_move_by_enemy unless @player_turn

      move

      check_winner
      switch_turn
    end
  end

  private

  def attacker
    @player_turn ? @player_pokemon : @enemy_pokemon
  end

  def receiver
    @player_turn ? @enemy_pokemon : @player_pokemon
  end

  def attacker_move
    @player_turn ? @current_player_pokemon_move : @current_enemy_pokemon_move
  end

  def introduction
    result = IntroductionResult.new(@enemy_pokemon, @player_pokemon).message
    Ui.display_messages(result)
  end

  def status
    result = StatusResult.new(player: @player_pokemon, enemy: @enemy_pokemon).message
    Ui.display_messages(result)
  end

  def battle_in_progress?
    return @player_pokemon.hp.positive? && @enemy_pokemon.hp.positive?
  end

  def select_move
    loop do
      selected_move = Ui.select_move(@player_pokemon.moves)  # 戻り値を受け取る

      if selected_move.useable?
        @current_player_pokemon_move = selected_move
        break
      else
        Ui.display_messages(["PPが なくなっている！ ほかの わざを えらんで ください。"])
      end
    end
  end

  def manual_select_move_by_enemy
    @current_enemy_pokemon_move = @enemy_pokemon.moves.sample
  end

  def switch_turn
    @player_turn = !@player_turn
  end

  def move
    result = MoveTurn.new(attacker, receiver, attacker_move).execute!
    Ui.display_messages(
      MoveResult.new(
        attacker:,
        receiver:,
        move: attacker_move,
        damage: result[:damage],
        effectiveness: result[:effectiveness],
        is_critical: result[:is_critical],
        condition: result[:condition],
        is_start_condition_effective: result[:is_start_condition_effective],
        is_hit: result[:is_hit],
        can_not_move_for_condition: result[:can_not_move_for_condition]
      ).message
    )
  end

  def check_winner
    return if battle_in_progress?

    winner = @player_pokemon.hp.positive? ? @player_pokemon : @enemy_pokemon
    loser = @player_pokemon.hp.positive? ? @enemy_pokemon : @player_pokemon
    Ui.display_messages(BattleResult.new(winner, loser).message)
    @winner = winner
  end
end