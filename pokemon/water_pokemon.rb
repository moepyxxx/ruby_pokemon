require_relative 'pokemon'

class WaterPokemon < Pokemon
  def initialize(name, max_hp)
    super(name, "みず", max_hp)
  end

  def special_move
    return "ハイドロポンプ"
  end
end