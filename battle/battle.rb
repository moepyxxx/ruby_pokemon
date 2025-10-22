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
  end

  def execute
    introduction

    while battle_in_progress?
      status

      select_move if @player_turn

      attack(attacker, receiver)
      check_winner
      switch_turn
    end
  end

  private

  def attacker
    return @player_turn ? @player_pokemon : @enemy_pokemon
  end

  def receiver
    return @player_turn ? @enemy_pokemon : @player_pokemon
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
    return @player_pokemon.hp > 0 && @enemy_pokemon.hp > 0
  end

  def select_move
    # TODO: implement move selection
  end

  def switch_turn
    @player_turn = !@player_turn
  end

  def attack(attacker, receiver)
    damage = rand(10..25)
    receiver.take_damage(damage)
    Ui.display_messages(AttackResult.new(attacker, receiver, damage).message)    
  end

  def check_winner
    if battle_over?
      winner = @player_pokemon.hp > 0 ? @player_pokemon : @enemy_pokemon
      loser = @player_pokemon.hp <= 0 ? @player_pokemon : @enemy_pokemon
      Ui.display_messages(TurnResult.new(winner, loser).message)
      @winner = winner
    end
  end

  def battle_over?
    return @player_pokemon.hp <= 0 || @enemy_pokemon.hp <= 0
  end
end