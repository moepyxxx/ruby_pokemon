require_relative '../pokemon/battle_pokemon'
require_relative 'introduction_result'
require_relative 'turn_result'
require_relative 'attack_result'
require_relative 'status_result'
require_relative '../ui'

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

      attack(attacker, receiver, attacker_move)
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
    @current_player_pokemon_move = Ui.select_move(@player_pokemon.moves)
  end

  def manual_select_move_by_enemy
    @current_enemy_pokemon_move = @enemy_pokemon.moves.sample
  end

  def switch_turn
    @player_turn = !@player_turn
  end

  def attack(attacker, receiver, attacker_move)
    damage = attacker.level * attacker_move[:power]
    receiver.take_damage!(damage)
    Ui.display_messages(AttackResult.new(attacker, receiver, attacker_move, damage).message)
  end

  def check_winner
    return if battle_in_progress?

    winner = @player_pokemon.hp.positive? ? @player_pokemon : @enemy_pokemon
    loser = @player_pokemon.hp.positive? ? @enemy_pokemon : @player_pokemon
    Ui.display_messages(TurnResult.new(winner, loser).message)
    @winner = winner
  end
end