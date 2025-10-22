
require_relative 'turn_result_interface'

class StatusResult
  include TurnResultInterface

  def initialize(enemy_pokemon, player_pokemon)
    @enemy_pokemon = enemy_pokemon
    @player_pokemon = player_pokemon
  end

  def message
    return [
      "#{@player_pokemon.name}(HP: #{@player_pokemon.hp}) - #{@enemy_pokemon.name}(HP: #{@enemy_pokemon.hp})"
    ]
  end
end