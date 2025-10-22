class PlayerPokemon
  attr_reader :pokemon, :level, :moves, :hp

  def initialize(pokemon, level, moves = [])
    @pokemon = pokemon
    @level = level
    @moves = moves
    @hp = level * 15
  end
end
