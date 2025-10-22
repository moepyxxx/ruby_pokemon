require_relative '../pokemon/battle_pokemon'
require_relative 'battle_status'
require_relative 'battle_message_generator'

class Battle
  @status = BattleStatus::START
  @winner = nil

  def initialize(player_pokemon, enemy_pokemon)
    @player_pokemon = player_pokemon
    @enemy_pokemon = enemy_pokemon
    @battle_message_generator = BattleMessageGenerator.new(@player_pokemon, @enemy_pokemon)
  end

  def introduction
    go_to_next_status
    return @battle_message_generator.introduction
  end

  def battle_in_progress?
    return @status != BattleStatus::DECIDE_WINNER
  end

  def player_pokemon
    @player_pokemon
  end

  def enemy_pokemon
    @enemy_pokemon
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

  def player_attack
    result = attack(@player_pokemon, @enemy_pokemon)
    go_to_next_status unless battle_over?
    return result
  end

  def enemy_attack
    result = attack(@enemy_pokemon, @player_pokemon)
    go_to_next_status unless battle_over?
    return result
  end

  private

  def attack(attacker, defender)
    texts = []
    damage = rand(10..25)
    defender.take_damage(damage)
    texts.push(*@battle_message_generator.attack(attacker, defender, damage))

    if battle_over?
      texts.push(*@battle_message_generator.battle_over(attacker, defender))
      @winner = attacker
      @status = BattleStatus::DECIDE_WINNER
    end

    return texts
  end

  def battle_over?
    return @player_pokemon.hp <= 0 || @enemy_pokemon.hp <= 0
  end

end