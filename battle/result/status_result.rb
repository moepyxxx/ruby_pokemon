
require_relative 'result_interface'

class StatusResult
  include ResultInterface

  def initialize(player:, enemy:)
    @player_pokemon = player
    @enemy_pokemon = enemy
  end

  def message
    return [
      "#{@player_pokemon.name}(HP: #{@player_pokemon.hp}) - #{@enemy_pokemon.name}(HP: #{@enemy_pokemon.hp})"
    ]
  end
end