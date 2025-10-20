require_relative 'pokemon'

class GrassPokemon < Pokemon
  def initialize(name, max_hp)
    super(name, "くさ", max_hp)
  end

  def special_move
    return "ソーラービーム"
  end
end