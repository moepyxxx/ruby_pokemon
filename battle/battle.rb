require_relative '../pokemon/battle_pokemon'
require_relative 'battle_status'
require_relative 'introduction_result'
require_relative 'turn_result'
require_relative 'attack_result'
require_relative 'status_result'
require_relative '../ui'

class Battle
  @status = BattleStatus::START
  @winner = nil
  @attacker = nil
  @receiver = nil

  def initialize(player_pokemon, enemy_pokemon)
    @player_pokemon = player_pokemon
    @enemy_pokemon = enemy_pokemon
    @attacker = player_pokemon
    @receiver = enemy_pokemon
  end

  def execute
    introductions = introduction
    Ui.display_messages(introductions)

    while battle_in_progress?
      Ui.display_messages(StatusResult.new(@enemy_pokemon, @player_pokemon).message)

      select_move

      attack(@attacker, @receiver)
      change_attacker
      check_winner
    end
  end

  private

  def introduction
    go_to_next_status
    result = IntroductionResult.new(@enemy_pokemon, @player_pokemon).message
    Ui.display_messages(result)
  end

  def battle_in_progress?
    return @status != BattleStatus::DECIDE_WINNER
  end

  def select_move
    # TODO: implement move selection
    go_to_next_status
  end

  def go_to_next_status
    case @status
    when BattleStatus::START
      @status = BattleStatus::SELECT_MOVE
    when BattleStatus::SELECT_MOVE
      @status = BattleStatus::ATTACK
    when BattleStatus::ATTACK
      @status = BattleStatus::BE_ATTACKED
    when BattleStatus::BE_ATTACKED
      if battle_over?
        @status = BattleStatus::DECIDE_WINNER
      else
        @status = BattleStatus::SELECT_MOVE
      end
    end
  end

  def change_attacker
    if @attacker == @player_pokemon
      @attacker = @enemy_pokemon
      @receiver = @player_pokemon
    else
      @attacker = @player_pokemon
      @receiver = @enemy_pokemon
    end
  end

  def attack(attacker, receiver)
    damage = rand(10..25)
    receiver.take_damage(damage)
    result = AttackResult.new(attacker, receiver, damage).message
    Ui.display_messages(result)    
  end

  def check_winner
    if battle_over?
      winner = @player_pokemon.hp > 0 ? @player_pokemon : @enemy_pokemon
      loser = @player_pokemon.hp <= 0 ? @player_pokemon : @enemy_pokemon
      Ui.display_messages(TurnResult.new(winner, loser).message)
      @winner = winner
      @status = BattleStatus::DECIDE_WINNER
    end
  end

  def battle_over?
    return @player_pokemon.hp <= 0 || @enemy_pokemon.hp <= 0
  end
end