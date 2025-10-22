class BattleMessageGenerator
  def initialize(player_pokemon, enemy_pokemon)
    @player_pokemon = player_pokemon
    @enemy_pokemon = enemy_pokemon
  end

  def introduction
    return [
      @enemy_pokemon.status,
      @player_pokemon.status, 
      "いけ！ #{@player_pokemon.name}！"
    ]
  end

  def attack(attacker, defender, damage)
    return [
      "#{attacker.name}の#{attacker.special_move}！",
      "#{defender.name}に#{damage}のダメージ！",
    ]
  end

  def battle_over(winner, loser)
    return [
      "#{loser.name}はたおれた！",
      "#{winner.name}のかちだ！"
    ]
  end
end