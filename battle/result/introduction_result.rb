
require_relative 'result_interface'

class IntroductionResult
  include ResultInterface

  def initialize(enemy_pokemon, player_pokemon)
    @enemy_pokemon = enemy_pokemon
    @player_pokemon = player_pokemon
  end

  def message
    return [
      @enemy_pokemon.status,
      @player_pokemon.status, 
      "いけ！ #{@player_pokemon.name}！"
    ]
  end
end