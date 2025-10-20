class PlayerPokemon
  attr_reader :pokemon, :level, :moves, :hp

  def initialize(pokemon, level, moves = [], hp)
    @pokemon = pokemon
    @level = level
    @moves = moves
    @hp = hp
  end
end
